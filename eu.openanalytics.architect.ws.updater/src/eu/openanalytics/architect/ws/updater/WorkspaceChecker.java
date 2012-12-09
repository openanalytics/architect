package eu.openanalytics.architect.ws.updater;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.Platform;
import org.eclipse.core.runtime.Status;
import org.osgi.framework.Version;

import eu.openanalytics.architect.ws.updater.util.Logger;
import eu.openanalytics.architect.ws.updater.util.StreamUtils;

public class WorkspaceChecker {

	public final static String JOB_TITLE = "Workspace Version Check";
	
	public IStatus run(IProgressMonitor monitor) {
		monitor.beginTask(JOB_TITLE, IProgressMonitor.UNKNOWN);
		
		WorkspaceAccessor wsAccessor = new WorkspaceAccessor();
		try {
			if (monitor.isCanceled()) return Status.CANCEL_STATUS;
			
			monitor.subTask("Retrieving workspace version");
			
			String wsVersionString = wsAccessor.getWorkspaceVersion();
			Version wsVersion = Version.parseVersion(wsVersionString);
			String latestVersionString = getPluginWorkspaceVersion();
			Version latestVersion = Version.parseVersion(latestVersionString);
			boolean updateRequired = (latestVersion.compareTo(wsVersion) > 0);
			
			if (updateRequired) {
				Logger.info("Workspace update required: " + latestVersion + " > "+ wsVersion);
				
				if (monitor.isCanceled()) return Status.CANCEL_STATUS;
				
				monitor.subTask("Installing new workspace resources");
				wsAccessor.replaceWorkspaceFolder(WorkspaceConstants.DEFAULT_PLUGIN_WS_PATH, "/");
				
				String[] extras = getPlatformSpecificWorkspaces();
				for (String extra: extras) {
					wsAccessor.replaceWorkspaceFolder(extra, "/");
				}
				
				monitor.subTask("Setting new workspace version");
				wsAccessor.setWorkspaceVersion(latestVersion.toString());
			} else {
				Logger.info("No workspace update needed: version " + wsVersion + " is up-to-date.");
			}
		} catch (IOException e) {
			return new Status(IStatus.ERROR, Activator.PLUGIN_ID, "Failed to update workspace: " + e.getMessage(), e);
		}
		
		if (monitor.isCanceled()) return Status.CANCEL_STATUS;
		
		monitor.done();
		return Status.OK_STATUS;
	}
	
	/*
	 * Non-public
	 * **********
	 */
	
	private String getPluginWorkspaceVersion() throws IOException {
		URL entry = Activator.getDefault().getBundle().getEntry("/workspace/" + WorkspaceConstants.VERSIONFILE_NAME);
		if (entry == null) return null;
		InputStream input = entry.openStream();
		ByteArrayOutputStream output = new ByteArrayOutputStream();
		StreamUtils.copyAndClose(input, output);
		return output.toString();
	}
	
	private String[] getPlatformSpecificWorkspaces() {
		
		List<String> components = new ArrayList<String>();
		
		String os = Platform.getOS();
		String ws = Platform.getWS();
		String arch = Platform.getOSArch();
		
		addPlatformSpecificWorkspaces(components, ws);
		addPlatformSpecificWorkspaces(components, ws + "." + os);
		addPlatformSpecificWorkspaces(components, ws + "." + os + "." + arch);
		
		return components.toArray(new String[components.size()]);
	}
	
	private void addPlatformSpecificWorkspaces(List<String> components, String wsName) {
		String searchPath = "/workspace/";
		Enumeration<URL> entries = Activator.getDefault().getBundle().findEntries(searchPath, wsName, false);
		while (entries != null && entries.hasMoreElements()) {
			URL entry = entries.nextElement();
			String entryString = entry.toString();
			boolean isFolder = entryString.endsWith("/");
			if (isFolder) components.add(searchPath + wsName + "/" + WorkspaceConstants.WS_PLUGINS_PATH);
		}
	}
}
