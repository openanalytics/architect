package eu.openanalytics.architect.rtools;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.FileLocator;
import org.eclipse.core.runtime.Platform;
import org.eclipse.core.variables.IDynamicVariable;
import org.eclipse.core.variables.IDynamicVariableResolver;

public class ArchitectRToolsResolver implements IDynamicVariableResolver {

	private static final String RTOOLS_DIR = "rtools";
	private static final String MINGW_DIR = "mingw_64";
	private static final String BIN_DIR = "bin";
	private static final String GCC_FILE = "gcc";
	
	private static final String OS_WIN32 = "win32";
	private static final String ARCH_X64 = "x86_64";
	
	private static final char PATH_SEP_WIN = ';';
	private static final char PATH_SEP_NIX = ':';
	
	@Override
	public String resolveValue(IDynamicVariable variable, String argument) throws CoreException {
		StringBuilder path = new StringBuilder();
		String rToolsPath = findRToolsPath();
		if (rToolsPath != null) {
			String[] binPaths = findBinPaths(rToolsPath);
			for (String binPath: binPaths) {
				path.append(binPath);
				path.append(isWindowsOS() ? PATH_SEP_WIN : PATH_SEP_NIX);
			}
		}
		return path.toString();
	}
	
	private String findRToolsPath() {
		try {
			File bundleFile = FileLocator.getBundleFile(Activator.getContext().getBundle());
			File pluginsDir = bundleFile.getParentFile();
			String bundleId = Activator.getContext().getBundle().getSymbolicName();
			
			String ws = Platform.getWS();
			String os = Platform.getOS();
			
			String bundleRegex = bundleId.replace(".", "\\.") + "\\." + ws + "\\." + os + ".*";
			Pattern bundlePattern = Pattern.compile(bundleRegex);
			
			String rToolsPath = null;
			for (File bundle: pluginsDir.listFiles()) {
				if (bundlePattern.matcher(bundle.getName()).matches() && bundle.isDirectory()) {
					boolean containsRTools = new File(bundle.getAbsolutePath() + '/' + RTOOLS_DIR).exists();
					if (containsRTools) {
						rToolsPath = getWindowsSafePath(pluginsDir, bundle.getName()) + '/' + RTOOLS_DIR;
						break;
					}
				}
			}
			return rToolsPath;
		} catch (IOException e) {
			return null;
		}
	}
	
	private String[] findBinPaths(String rToolsPath) {
		List<String> binPaths = new ArrayList<String>();
		
		File file = new File(rToolsPath + '/' + BIN_DIR);
		if (file.exists()) binPaths.add(file.getAbsolutePath());
		
		file = new File(rToolsPath + '/' + MINGW_DIR + '/' + BIN_DIR);
		if (file.exists()) binPaths.add(file.getAbsolutePath());
		
		return binPaths.toArray(new String[binPaths.size()]);
	}
	
	private String getWindowsSafePath(File pluginsDir, String pluginName) {
		String safePath = pluginsDir.getAbsolutePath() + "/" + pluginName;
		if (!isWindowsOS()) return safePath;
		
		// Warning! Ugly workaround for Sys.which crashing on long path names (Windows only).
		try {
			// Execute a dir /x command to obtain the short name.
			String[] cmd = { "cmd.exe", "/c", "dir", pluginsDir.getAbsolutePath(), "/x" };
			Process process = new ProcessBuilder().command(cmd).start();
			InputStream input = process.getInputStream();
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			copyAndClose(input, out);
			process.waitFor();
			// Parse the short name from the return string.
			String retVal = new String(out.toByteArray());
			String[] lines = retVal.split(System.getProperty("line.separator"));
			String matchingLine = null;
			for (String line: lines) {
				if (line.contains(pluginName)) {
					matchingLine = line;
					break;
				}
			}
			if (matchingLine != null && matchingLine.contains("<DIR>")) {
				matchingLine = matchingLine.substring(matchingLine.indexOf("<DIR>")+5).trim();
				matchingLine = matchingLine.substring(0, matchingLine.indexOf(' ')).trim();
				if (!matchingLine.isEmpty()) safePath = pluginsDir.getAbsolutePath() + "/" + matchingLine;
			}
		} catch (Exception e) {}
		
		return safePath;
	}
	
	private void copyAndClose(InputStream in, OutputStream out) throws IOException {
		try {
			byte[] buffer = new byte[4096];
			int len = 0;
			do {
				len = in.read(buffer, 0, buffer.length);
				if (len > 0) out.write(buffer, 0, len);
			} while (len >= 0);
		} finally {
			if (in != null) try { in.close(); } catch	(IOException e) {}
			if (out != null) try { out.close(); } catch	(IOException e) {}
		}
	}
	
	private boolean isWindowsOS() {
		return OS_WIN32.equals(Platform.getOS());
	}
}
