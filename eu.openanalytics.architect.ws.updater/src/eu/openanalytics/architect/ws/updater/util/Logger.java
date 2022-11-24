package eu.openanalytics.architect.ws.updater.util;

import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.Status;

import eu.openanalytics.architect.ws.updater.Activator;

public class Logger {
	
	public static void info(String msg) {
		Activator.getDefault().getLog().log(new Status(IStatus.INFO, Activator.PLUGIN_ID, msg));
	}

	public static void warn(String msg) {
		Activator.getDefault().getLog().log(new Status(IStatus.WARNING, Activator.PLUGIN_ID, msg));
	}
	
	public static void error(String msg) {
		error(msg, null);
	}
	
	public static void error(String msg, Throwable cause) {
		Activator.getDefault().getLog().log(new Status(IStatus.ERROR, Activator.PLUGIN_ID, msg, cause));
	}
}
