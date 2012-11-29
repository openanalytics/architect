package eu.openanalytics.architect.ws.updater;

import java.io.IOException;

import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.Status;
import org.osgi.framework.Version;

import eu.openanalytics.architect.ws.updater.util.Logger;

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
			Version latestVersion = Activator.getDefault().getBundle().getVersion();
			boolean updateRequired = (latestVersion.compareTo(wsVersion) > 0);
			
			if (updateRequired) {
				Logger.info("Workspace update required: " + latestVersion + " > "+ wsVersion);
				
				if (monitor.isCanceled()) return Status.CANCEL_STATUS;
				
				monitor.subTask("Installing new workspace resources");
				wsAccessor.replaceWorkspaceFolder(WorkspaceConstants.PATH_TO_COPY_FROM, "/");
				
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
}
