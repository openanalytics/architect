package eu.openanalytics.architect;

import org.eclipse.core.resources.ResourcesPlugin;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IAdaptable;
import org.eclipse.core.runtime.IProduct;
import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.Platform;
import org.eclipse.core.runtime.Status;
import org.eclipse.jface.util.IPropertyChangeListener;
import org.eclipse.jface.util.PropertyChangeEvent;
import org.eclipse.osgi.util.NLS;
import org.eclipse.swt.dnd.FileTransfer;
import org.eclipse.swt.graphics.Point;
import org.eclipse.ui.IEditorPart;
import org.eclipse.ui.IEditorReference;
import org.eclipse.ui.IPageListener;
import org.eclipse.ui.IPartListener2;
import org.eclipse.ui.IPerspectiveDescriptor;
import org.eclipse.ui.IPropertyListener;
import org.eclipse.ui.IWorkbenchPage;
import org.eclipse.ui.IWorkbenchPartConstants;
import org.eclipse.ui.IWorkbenchPartReference;
import org.eclipse.ui.IWorkbenchWindow;
import org.eclipse.ui.PerspectiveAdapter;
import org.eclipse.ui.application.ActionBarAdvisor;
import org.eclipse.ui.application.IActionBarConfigurer;
import org.eclipse.ui.application.IWorkbenchWindowConfigurer;
import org.eclipse.ui.application.WorkbenchWindowAdvisor;
import org.eclipse.ui.internal.ide.EditorAreaDropAdapter;
import org.eclipse.ui.internal.ide.IDEInternalPreferences;
import org.eclipse.ui.internal.ide.IDEWorkbenchPlugin;
import org.eclipse.ui.internal.ide.WorkbenchActionBuilder;
import org.eclipse.ui.part.EditorInputTransfer;
import org.eclipse.ui.part.MarkerTransfer;
import org.eclipse.ui.part.ResourceTransfer;

@SuppressWarnings("restriction")
public class ApplicationWorkbenchWindowAdvisor extends WorkbenchWindowAdvisor {

	private IEditorPart lastActiveEditor = null;
	private IWorkbenchPage lastActivePage;
	private String lastEditorTitle = ""; //$NON-NLS-1$
	private IPerspectiveDescriptor lastPerspective = null;
	private IAdaptable lastInput;
	private IPropertyChangeListener propertyChangeListener;
	private IPropertyListener editorPropertyListener = new IPropertyListener() {
		public void propertyChanged(Object source, int propId) {
			if (propId == IWorkbenchPartConstants.PROP_TITLE) {
				if (lastActiveEditor != null) {
					String newTitle = lastActiveEditor.getTitle();
					if (!lastEditorTitle.equals(newTitle)) {
						recomputeTitle();
					}
				}
			}
		}
	};
	
	public ApplicationWorkbenchWindowAdvisor(IWorkbenchWindowConfigurer configurer) {
		super(configurer);
	}

	public ActionBarAdvisor createActionBarAdvisor(IActionBarConfigurer configurer) {
		return new WorkbenchActionBuilder(configurer);
	}

	public void preWindowOpen() {
		IWorkbenchWindowConfigurer configurer = getWindowConfigurer();
		
		configurer.setInitialSize(new Point(1024, 768));
		configurer.setShowCoolBar(true);
		configurer.setShowStatusLine(true);
		configurer.setShowMenuBar(true);
		configurer.setShowPerspectiveBar(true);

		// add the drag and drop support for the editor area
		configurer.addEditorAreaTransfer(EditorInputTransfer.getInstance());
		configurer.addEditorAreaTransfer(ResourceTransfer.getInstance());
		configurer.addEditorAreaTransfer(FileTransfer.getInstance());
		configurer.addEditorAreaTransfer(MarkerTransfer.getInstance());
		configurer.configureEditorAreaDropListener(new EditorAreaDropAdapter(
				configurer.getWindow()));
				
		hookTitleUpdateListeners(configurer);
	}

	@Override
	public void postWindowOpen() {
		IWorkbenchWindowConfigurer configurer = getWindowConfigurer();
		
		configurer.getWindow().getShell().setMaximized(true); 
	}

	@Override  
	public boolean preWindowShellClose() {  
		try {  
			ResourcesPlugin.getWorkspace().save(true, null);  
		} catch (final CoreException e) {
			IStatus status = new Status(IStatus.ERROR, Activator.PLUGIN_ID, "Failed to save workspace state", e); //$NON-NLS-1$
			Activator.getDefault().getLog().log(status);
		}  

		return true;  
	}

	/*
	 * Title-update mechanism from Eclipse IDE
	 */
	
	private void hookTitleUpdateListeners(IWorkbenchWindowConfigurer configurer) {
		// hook up the listeners to update the window title
		configurer.getWindow().addPageListener(new IPageListener() {
			public void pageActivated(IWorkbenchPage page) {
				updateTitle(false);
			}

			public void pageClosed(IWorkbenchPage page) {
				updateTitle(false);
			}

			public void pageOpened(IWorkbenchPage page) {
				// do nothing
			}
		});
		configurer.getWindow().addPerspectiveListener(new PerspectiveAdapter() {
			public void perspectiveActivated(IWorkbenchPage page,
					IPerspectiveDescriptor perspective) {
				updateTitle(false);
			}

			public void perspectiveSavedAs(IWorkbenchPage page,
					IPerspectiveDescriptor oldPerspective,
					IPerspectiveDescriptor newPerspective) {
				updateTitle(false);
			}

			public void perspectiveDeactivated(IWorkbenchPage page,
					IPerspectiveDescriptor perspective) {
				updateTitle(false);
			}
		});
		configurer.getWindow().getPartService().addPartListener(
				new IPartListener2() {
					public void partActivated(IWorkbenchPartReference ref) {
						if (ref instanceof IEditorReference) {
							updateTitle(false);
						}
					}

					public void partBroughtToTop(IWorkbenchPartReference ref) {
						if (ref instanceof IEditorReference) {
							updateTitle(false);
						}
					}

					public void partClosed(IWorkbenchPartReference ref) {
						updateTitle(false);
					}

					public void partDeactivated(IWorkbenchPartReference ref) {
						// do nothing
					}

					public void partOpened(IWorkbenchPartReference ref) {
						// do nothing
					}

					public void partHidden(IWorkbenchPartReference ref) {
						if (ref.getPart(false) == lastActiveEditor
								&& lastActiveEditor != null) {
							updateTitle(true);
						}
					}

					public void partVisible(IWorkbenchPartReference ref) {
						if (ref.getPart(false) == lastActiveEditor
								&& lastActiveEditor != null) {
							updateTitle(false);
						}
					}

					public void partInputChanged(IWorkbenchPartReference ref) {
						// do nothing
					}
				});
		
		// Listen for changes of the workspace name.
		propertyChangeListener = new IPropertyChangeListener() {
			public void propertyChange(PropertyChangeEvent event) {
				if (IDEInternalPreferences.WORKSPACE_NAME.equals(event
						.getProperty())) {
					// Make sure the title is actually updated by
					// setting last active page.
					lastActivePage = null;
					updateTitle(false);
				}
			}
		};
		IDEWorkbenchPlugin.getDefault().getPreferenceStore()
				.addPropertyChangeListener(propertyChangeListener);
	}
	
	private String computeTitle() {
		IWorkbenchWindowConfigurer configurer = getWindowConfigurer();
		IWorkbenchPage currentPage = configurer.getWindow().getActivePage();
		IEditorPart activeEditor = null;
		if (currentPage != null) {
			activeEditor = lastActiveEditor;
		}

		String title = null;
		IProduct product = Platform.getProduct();
		if (product != null) {
			title = product.getName();
		}
		if (title == null) {
			title = ""; //$NON-NLS-1$
		}

		if (currentPage != null) {
			if (activeEditor != null) {
				lastEditorTitle = activeEditor.getTitleToolTip();
				title = NLS.bind("{0} - {1}", lastEditorTitle, title);
			}
		}

		// Bug 284447: Prepend workspace name to the title
		String workspaceName = IDEWorkbenchPlugin.getDefault()
				.getPreferenceStore().getString(
						IDEInternalPreferences.WORKSPACE_NAME);
		if (workspaceName != null && workspaceName.length() > 0) {
			title = NLS.bind("{0} - {1}", workspaceName, title);
		}

		return title;
	}
	
	private void recomputeTitle() {
		IWorkbenchWindowConfigurer configurer = getWindowConfigurer();
		String oldTitle = configurer.getTitle();
		String newTitle = computeTitle();
		if (!newTitle.equals(oldTitle)) {
			configurer.setTitle(newTitle);
		}
	}

	/**
	 * Updates the window title. Format will be: [pageInput -]
	 * [currentPerspective -] [editorInput -] [workspaceLocation -] productName
	 * @param editorHidden TODO
	 */
	private void updateTitle(boolean editorHidden) {
		IWorkbenchWindowConfigurer configurer = getWindowConfigurer();
		IWorkbenchWindow window = configurer.getWindow();
		IEditorPart activeEditor = null;
		IWorkbenchPage currentPage = window.getActivePage();
		IPerspectiveDescriptor persp = null;
		IAdaptable input = null;

		if (currentPage != null) {
			activeEditor = currentPage.getActiveEditor();
			persp = currentPage.getPerspective();
			input = currentPage.getInput();
		}
		
		if (editorHidden) {
			activeEditor = null;
		}

		// Nothing to do if the editor hasn't changed
		if (activeEditor == lastActiveEditor && currentPage == lastActivePage
				&& persp == lastPerspective && input == lastInput) {
			return;
		}

		if (lastActiveEditor != null) {
			lastActiveEditor.removePropertyListener(editorPropertyListener);
		}

		lastActiveEditor = activeEditor;
		lastActivePage = currentPage;
		lastPerspective = persp;
		lastInput = input;

		if (activeEditor != null) {
			activeEditor.addPropertyListener(editorPropertyListener);
		}

		recomputeTitle();
	}
}
