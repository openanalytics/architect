package eu.openanalytics.architect.rtools;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.FileLocator;
import org.eclipse.core.runtime.Platform;
import org.eclipse.core.variables.IDynamicVariable;
import org.eclipse.core.variables.IDynamicVariableResolver;

public class ArchitectRToolsResolver implements IDynamicVariableResolver {

	private final static String RTOOLS_DIR = "rtools";
	private final static String BIN_DIR = "bin";
	
	@Override
	public String resolveValue(IDynamicVariable variable, String argument) throws CoreException {
		StringBuilder path = new StringBuilder();
		String rToolsPath = findRToolsPath();
		if (rToolsPath != null) {
			String[] binPaths = findBinPaths(rToolsPath);
			for (String binPath: binPaths) {
				path.append(binPath);
				path.append(';');
			}
		}
		return path.toString();
	}
	
	protected String findRToolsPath() {
		try {
			File bundleFile = FileLocator.getBundleFile(Activator.getContext().getBundle());
			String bundlePath = bundleFile.getAbsolutePath();
			
			// First, attempt to find the folder in the current plugin.
			File rtoolsPath = new File(bundlePath + '/' + RTOOLS_DIR);
			if (rtoolsPath.exists()) return rtoolsPath.getAbsolutePath();
			
			// If that fails, check for the existence of a plugin fragment.
			String ws = Platform.getWS();
			String os = Platform.getOS();
			String arch = Platform.getOSArch();
			
			rtoolsPath = new File(bundlePath + '.' + ws + '/' + RTOOLS_DIR);
			if (rtoolsPath.exists()) return rtoolsPath.getAbsolutePath();
			
			rtoolsPath = new File(bundlePath + '.' + ws + '.' + os + '/' + RTOOLS_DIR);
			if (rtoolsPath.exists()) return rtoolsPath.getAbsolutePath();
			
			rtoolsPath = new File(bundlePath + '.' + ws + '.' + os + '.' + arch + '/' + RTOOLS_DIR);
			if (rtoolsPath.exists()) return rtoolsPath.getAbsolutePath();
		} catch (IOException e) {
			return null;
		}
		return null;
	}
	
	protected String[] findBinPaths(String rToolsPath) {
		List<String> binPaths = new ArrayList<String>();
		
		File file = new File(rToolsPath + '/' + BIN_DIR);
		if (file.exists()) binPaths.add(file.getAbsolutePath());
		
		String gccName = null;
		for (File child: new File(rToolsPath).listFiles()) {
			if (child.getName().toLowerCase().contains("gcc")) {
				gccName = child.getName();
				break;
			}
		}
		if (gccName != null) {
			file = new File(rToolsPath + '/' + gccName + '/' + BIN_DIR);
			if (file.exists()) binPaths.add(file.getAbsolutePath());
			
			String binSuffix = "32";
			if (Platform.getOSArch().equalsIgnoreCase("x86_64")) binSuffix = "64";
			
			file = new File(rToolsPath + '/' + gccName + '/' + BIN_DIR + binSuffix);
			if (file.exists()) binPaths.add(file.getAbsolutePath());
		}
		
		return binPaths.toArray(new String[binPaths.size()]);
	}
}
