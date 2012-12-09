package eu.openanalytics.architect.ws.updater;

public class WorkspaceConstants {

	/**
	 * The name of the file containing the workspace version.
	 */
	public final static String VERSIONFILE_NAME = "ws.version.info";
	
	/**
	 * The path inside the workspace containing the plugin settings.
	 */
	public final static String WS_PLUGINS_PATH = ".metadata/.plugins";

	/**
	 * The path inside the workspace referring to the version file.
	 */
	public final static String WS_VERSIONFILE_PATH = WS_PLUGINS_PATH + "/" + Activator.PLUGIN_ID + "/" + VERSIONFILE_NAME;
	
	/**
	 * The path inside this plugin containing up-to-date workspace files.
	 */
	public final static String DEFAULT_PLUGIN_WS_PATH = "/workspace/default/" + WS_PLUGINS_PATH;
}
