package eu.openanalytics.architect.ui;

import org.eclipse.debug.ui.IDebugUIConstants;
import org.eclipse.ui.IFolderLayout;
import org.eclipse.ui.IPageLayout;
import org.eclipse.ui.IPerspectiveFactory;

public class ArchitectPerspective implements IPerspectiveFactory {

	public static final String ID = "eu.openanalytics.architect.ui.ArchitectPerspective"; //$NON-NLS-1$
	
	private static final String ID_CONSOLE_VIEW = "org.eclipse.ui.console.ConsoleView"; //$NON-NLS-1$
	private static final String ID_TASK_VIEW = "org.eclipse.ui.views.TaskList"; //$NON-NLS-1$
	private static final String ID_ERROR_VIEW = "org.eclipse.pde.runtime.LogView"; //$NON-NLS-1$
	private static final String ID_OUTLINE_VIEW = "org.eclipse.ui.views.ContentOutline"; //$NON-NLS-1$
	
	private static final String ID_NICO_CMDHISTORY_VIEW = "org.eclipse.statet.nico.views.HistoryView"; //$NON-NLS-1$
	private static final String ID_NICO_OBJECTBROWSER_VIEW = "org.eclipse.statet.nico.views.ObjectBrowser"; //$NON-NLS-1$

	private static final String ID_R_GRAPHICS = "org.eclipse.statet.r.views.RGraphic"; //$NON-NLS-1$

	private static final String ID_R_HELP = "org.eclipse.statet.r.views.RHelp"; //$NON-NLS-1$
	
	@Override
	public void createInitialLayout(IPageLayout layout) {
		final String editorArea = layout.getEditorArea();

		final IFolderLayout topLeftFolder = layout.createFolder("topLeftFolder", IPageLayout.LEFT, 0.25f, editorArea); //$NON-NLS-1$
		topLeftFolder.addView(IPageLayout.ID_PROJECT_EXPLORER);
		
		IFolderLayout bottomLeftFolder = layout.createFolder("bottomLeftFolder", IPageLayout.BOTTOM, 0.6f, IPageLayout.ID_PROJECT_EXPLORER); //$NON-NLS-1$
		bottomLeftFolder.addView(ID_NICO_OBJECTBROWSER_VIEW);
		bottomLeftFolder.addView(ID_R_HELP);
		bottomLeftFolder.addView(ID_R_GRAPHICS);

		IFolderLayout bottomMiddleFolder = layout.createFolder("bottomMiddleFolder", IPageLayout.BOTTOM, 0.6f, editorArea); //$NON-NLS-1$
		bottomMiddleFolder.addView(ID_CONSOLE_VIEW);
		bottomMiddleFolder.addView(ID_NICO_CMDHISTORY_VIEW);
		bottomMiddleFolder.addView(ID_TASK_VIEW);
		bottomMiddleFolder.addView(ID_ERROR_VIEW);
		
		final IFolderLayout topRightFolder = layout.createFolder("topRightFolder", IPageLayout.RIGHT, 0.75f, editorArea); //$NON-NLS-1$
		topRightFolder.addView(ID_OUTLINE_VIEW);
		
		layout.addActionSet(IDebugUIConstants.LAUNCH_ACTION_SET);
		layout.addActionSet(IPageLayout.ID_NAVIGATE_ACTION_SET);
	}

}
