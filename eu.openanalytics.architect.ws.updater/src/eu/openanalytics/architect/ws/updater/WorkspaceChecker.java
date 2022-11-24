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
			
			if (wsVersion.equals(Version.emptyVersion)) {
				// No version present yet: copy the initial files.
				Logger.info("Workspace is unversioned: copying initial files");
				copyResources("workspace.initial", wsAccessor);
			}
			
			if (latestVersion.compareTo(wsVersion) > 0) {
				// Older version found: copy the controlled.versioned files.
				Logger.info("Workspace update required: " + latestVersion + " > "+ wsVersion);
				if (monitor.isCanceled()) return Status.CANCEL_STATUS;
				copyResources("workspace.controlled.versioned", wsAccessor);
				wsAccessor.setWorkspaceVersion(latestVersion.toString());				
			} else {
				Logger.info("Workspace version is up-to-date: " + wsVersion);
			}
			
			// Copy controlled.auto files, if any.
			copyResources("workspace.controlled.auto", wsAccessor);
			
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
	
	private void copyResources(String workspaceName, WorkspaceAccessor wsAccessor) throws IOException {
		wsAccessor.replaceWorkspaceFolder("/" + workspaceName + "/default/.metadata/.plugins", "/");
		String[] extras = getPlatformSpecificWorkspaces("/" + workspaceName + "/");
		for (String extra: extras) wsAccessor.replaceWorkspaceFolder(extra, "/");
	}
	
	private String getPluginWorkspaceVersion() throws IOException {
		URL entry = Activator.getDefault().getBundle().getEntry("/workspace.controlled.versioned/" + WorkspaceConstants.VERSIONFILE_NAME);
		if (entry == null) return null;
		InputStream input = entry.openStream();
		ByteArrayOutputStream output = new ByteArrayOutputStream();
		StreamUtils.copyAndClose(input, output);
		return output.toString();
	}
	
	private String[] getPlatformSpecificWorkspaces(String workspacePath) {
		
		List<String> components = new ArrayList<String>();
		
		String os = Platform.getOS();
		String ws = Platform.getWS();
		String arch = Platform.getOSArch();
		
		addPlatformSpecificWorkspaces(workspacePath, components, ws);
		addPlatformSpecificWorkspaces(workspacePath, components, ws + "." + os);
		addPlatformSpecificWorkspaces(workspacePath, components, ws + "." + os + "." + arch);
		
		return components.toArray(new String[components.size()]);
	}
	
	private void addPlatformSpecificWorkspaces(String workspacePath, List<String> components, String wsName) {
		String searchPath = workspacePath;
		Enumeration<URL> entries = Activator.getDefault().getBundle().findEntries(searchPath, wsName, false);
		while (entries != null && entries.hasMoreElements()) {
			URL entry = entries.nextElement();
			String entryString = entry.toString();
			boolean isFolder = entryString.endsWith("/");
			if (isFolder) components.add(searchPath + wsName + "/" + WorkspaceConstants.WS_PLUGINS_PATH);
		}
	}
}
