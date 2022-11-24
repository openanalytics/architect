package eu.openanalytics.architect.variable;

import java.io.File;
import java.net.URI;

import org.eclipse.core.filesystem.EFS;
import org.eclipse.core.resources.IResource;
import org.eclipse.core.resources.ResourcesPlugin;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.Path;
import org.eclipse.core.variables.IDynamicVariable;
import org.eclipse.core.variables.IDynamicVariableResolver;
import org.eclipse.core.variables.IStringVariableManager;
import org.eclipse.core.variables.VariablesPlugin;

public class ArchitectResourceResolver implements IDynamicVariableResolver {

	@Override
	public String resolveValue(IDynamicVariable variable, String argument) throws CoreException {
		IResource resource = getSelectedResource(variable);
		if (resource != null && resource.exists()) {
			URI uri = resource.getLocationURI();
			if(uri != null) {
				File file = EFS.getStore(uri).toLocalFile(0, null);
				if(file != null) {
					if (file.isFile()) {
						return file.getParentFile().getAbsolutePath();
					} else {
						return file.getAbsolutePath();
					}
				}
			}
		} else {
			String currentWD = System.getProperty("user.dir"); //$NON-NLS-1$
			return currentWD;
		}
		return null;
	}

	protected IResource getSelectedResource(IDynamicVariable variable) throws CoreException {
		IStringVariableManager manager = VariablesPlugin.getDefault().getStringVariableManager();
		try {
			String pathString = manager.performStringSubstitution("${selected_resource_path}"); //$NON-NLS-1$
			return ResourcesPlugin.getWorkspace().getRoot().findMember(new Path(pathString));
		} catch (CoreException e) {
			// unable to resolve a selection
		}
		return null;	
	}
}
