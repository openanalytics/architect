package eu.openanalytics.architect.workspace;

import org.eclipse.core.resources.ResourcesPlugin;
import org.eclipse.core.runtime.IAdaptable;
import org.eclipse.ui.IElementFactory;
import org.eclipse.ui.IMemento;
import org.eclipse.ui.IPersistableElement;
import org.eclipse.ui.model.IWorkbenchAdapter;

public class NavigatorRoot implements IAdaptable, IPersistableElement, IElementFactory {
	
	public NavigatorRoot() {
	}

	@SuppressWarnings("rawtypes")
	public Object getAdapter(Class adapter) {
		if (adapter == IPersistableElement.class)
			return this;
		if (adapter == IWorkbenchAdapter.class)
			return ResourcesPlugin.getWorkspace().getRoot().getAdapter(adapter);
		return null;
	}

	public String getFactoryId() {
		return this.getClass().getCanonicalName();
	}

	public void saveState(IMemento memento) {
		// TODO Auto-generated method stub
		return;
	}

	public IAdaptable createElement(IMemento memento) {
		return ResourcesPlugin.getWorkspace().getRoot();
	}
} 