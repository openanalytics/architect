package eu.openanalytics.architect.ws.updater;

public class WorkspaceConstants {

	/**
	 * The path inside the workspace containing the per-plugin settings.
	 */
	public final static String WS_PLUGINS_PATH = ".metadata/.plugins";
	
	/**
	 * The path inside the workspace referring to the version file.
	 */
	public final static String WS_VERSIONFILE_PATH = WS_PLUGINS_PATH + "/" + Activator.PLUGIN_ID + "/ws.version.info";
	
	/**
	 * The path inside this plugin containing up-to-date workspace files.
	 */
	public final static String PATH_TO_COPY_FROM = "/workspace/" + WS_PLUGINS_PATH;
}
