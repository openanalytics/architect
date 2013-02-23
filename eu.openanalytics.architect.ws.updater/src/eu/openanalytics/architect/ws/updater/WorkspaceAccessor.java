package eu.openanalytics.architect.ws.updater;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.Enumeration;

import org.eclipse.core.runtime.Platform;
import org.eclipse.osgi.service.datalocation.Location;

import eu.openanalytics.architect.ws.updater.util.StreamUtils;

/**
 * This class contains methods to read and write in the workspace area
 * (often the same folder as the "data area").
 * 
 * When writing to the workspace, keep in mind that the changes will not
 * affect the current session unless they are made before the workbench is created,
 */
public class WorkspaceAccessor {

	private Location dataArea;
	
	private final static boolean IS_WIN32 = Platform.getOS().equalsIgnoreCase("win32");
	
	public WorkspaceAccessor() {
		dataArea = Platform.getInstanceLocation();
	}
	
	/**
	 * Obtain the current version of the workspace, as defined by the value in the file
	 * given by WorkspaceConstants.WS_VERSIONFILE_PATH.
	 * 
	 * @return The current workspace version, or null if there is no version to be found.
	 * @throws IOException If the version file cannot be read.
	 */
	public String getWorkspaceVersion() throws IOException {
		String path = getAbsolutePath(WorkspaceConstants.WS_VERSIONFILE_PATH);
		if (new File(path).exists()) {
			InputStream inStream = new FileInputStream(path);
			ByteArrayOutputStream outStream = new ByteArrayOutputStream();
			StreamUtils.copyAndClose(inStream, outStream);
			return new String(outStream.toByteArray());
		} else {
			return null;
		}
	}
	
	/**
	 * Change the version of the workspace to newVersion.
	 * The version is maintained in the file given by WorkspaceConstants.WS_VERSIONFILE_PATH.
	 * 
	 * @param newVersion The new version number to set.
	 * @throws IOException If the version file cannot be altered.
	 */
	public void setWorkspaceVersion(String newVersion) throws IOException {
		replaceWorkspaceResource(new ByteArrayInputStream(newVersion.getBytes()), WorkspaceConstants.WS_VERSIONFILE_PATH);
	}
	
	/**
	 * Replace the workspace folder given by destinationPath with the contents of the folder
	 * given by sourcePath. Existing items will be overwritten. Subfolders will be copied recursively.
	 * 
	 * @param sourcePath The source path (inside this plugin) to copy.
	 * @param destinationPath The destination path (in the workspace) to copy to.
	 * @throws IOException If the copy fails.
	 */
	public void replaceWorkspaceFolder(String sourcePath, String destinationPath) throws IOException {
		String path = getAbsolutePath(destinationPath);
		unpackResources(sourcePath, new File(path));
	}
	
	/**
	 * Create or replace the contents of the workspace file at destinationPath with the contents
	 * of the InputStream.
	 * 
	 * @param contents The contents to write.
	 * @param destinationPath The destination file (in the workspace) to write to.
	 * @throws IOException If the write operation fails.
	 */
	public void replaceWorkspaceResource(InputStream contents, String destinationPath) throws IOException {
		String path = getAbsolutePath(destinationPath);
		new File(path).getParentFile().mkdirs();
		
		OutputStream outStream = new FileOutputStream(path);
		StreamUtils.copyAndClose(contents, outStream);
	}
	
	/*
	 * Non-public
	 * **********
	 */
	
	private String getAbsolutePath(String relativePath) throws IOException {
		if (relativePath.startsWith(WorkspaceConstants.WS_PLUGINS_PATH)) {
			relativePath = relativePath.substring(WorkspaceConstants.WS_PLUGINS_PATH.length());
		}
		while (relativePath.startsWith("/")) relativePath = relativePath.substring(1);
		URL url = dataArea.getDataArea(relativePath);
		String absolutePath = url.getFile();
		while (IS_WIN32 && absolutePath.startsWith("/")) absolutePath = absolutePath.substring(1);
		return absolutePath;
	}
	
	private void unpackResources(String pluginPath, File destination) throws IOException {
		destination.mkdirs();
		
		Enumeration<URL> entries = Activator.getDefault().getBundle().findEntries(pluginPath, "*", false);
		while (entries != null && entries.hasMoreElements()) {
			URL entry = entries.nextElement();
			String entryString = entry.toString();
			boolean isFolder = entryString.endsWith("/");
			while (entryString.endsWith("/")) entryString = entryString.substring(0,  entryString.length() - 1);
			String entryName = entryString.substring(entryString.lastIndexOf('/') + 1);
			if (isFolder) {
				String subPath = pluginPath + "/" + entryName;
				unpackResources(subPath, new File(destination + "/" + entryName));
			} else {
				InputStream input = entry.openStream();
				OutputStream output = new FileOutputStream(destination.getAbsolutePath() + "/" + entryName);
				StreamUtils.copyAndClose(input, output);
			}
		}
	}
}
