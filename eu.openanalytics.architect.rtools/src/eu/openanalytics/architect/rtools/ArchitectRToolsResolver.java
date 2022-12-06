package eu.openanalytics.architect.rtools;

import java.io.IOException;
import java.net.URISyntaxException;
import java.nio.file.Path;

import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.FileLocator;
import org.eclipse.core.variables.IDynamicVariable;
import org.eclipse.core.variables.IDynamicVariableResolver;
import org.eclipse.statet.jcommons.io.UriUtils;
import org.osgi.framework.Bundle;


public class ArchitectRToolsResolver implements IDynamicVariableResolver {
	
	
	private static final String RTOOLS_DIR= "rtools"; //$NON-NLS-1$
	private static final org.eclipse.core.runtime.Path RTOOLS_DIR_EPATH= new org.eclipse.core.runtime.Path(RTOOLS_DIR);
	
	
	@Override
	public String resolveValue(IDynamicVariable variable, String argument) throws CoreException {
		var rToolsPath = findRToolsPath();
		if (rToolsPath != null) {
			return rToolsPath.toString();
		}
		return ""; //$NON-NLS-1$
	}
	
	private Path findRToolsPath() {
		try {
			final Bundle bundle= Activator.getContext().getBundle();
			final var eUrl= FileLocator.find(bundle, RTOOLS_DIR_EPATH);
			if (eUrl != null) {
				final var fileUrl= FileLocator.toFileURL(eUrl);
				if (fileUrl != null) {
					return Path.of(UriUtils.toUri(fileUrl));
				}
			}
			return null;
		}
		catch (IOException | URISyntaxException e) {
			return null;
		}
	}
	
}
