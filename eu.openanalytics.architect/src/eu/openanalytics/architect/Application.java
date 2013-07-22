package eu.openanalytics.architect;

import org.eclipse.core.runtime.NullProgressMonitor;
import org.eclipse.core.runtime.Platform;
import org.eclipse.equinox.app.IApplication;
import org.eclipse.equinox.app.IApplicationContext;
import org.eclipse.osgi.service.datalocation.Location;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.ui.IWorkbench;
import org.eclipse.ui.PlatformUI;

import eu.openanalytics.architect.ws.updater.WorkspaceChecker;

/**
 * This class controls all aspects of the application's execution
 */
public class Application implements IApplication {

	private static final String PROP_EXIT_CODE = "eclipse.exitcode"; //$NON-NLS-1$
    
	/* (non-Javadoc)
	 * @see org.eclipse.equinox.app.IApplication#start(org.eclipse.equinox.app.IApplicationContext)
	 */
	@SuppressWarnings({ "deprecation", "restriction" })
	public Object start(IApplicationContext context) throws Exception {
		Display display = PlatformUI.createDisplay();
		try {
			// Call Eclipse IDE code to check instance area (prompt if needed, lock it, etc.)
			IDEApplicationCompatibility ideComp = new IDEApplicationCompatibility();
	    	Shell shell = ideComp.getShell(display);
	        Object instanceLocationCheck = ideComp.checkInstanceLocation(shell, context.getArguments());
			if (instanceLocationCheck != null) {
				org.eclipse.ui.internal.WorkbenchPlugin.unsetSplashShell(display);
	            Platform.endSplash();
	            return instanceLocationCheck;
	        }
			
			// Explicitly invoke the WorkspaceChecker here, before the workbench is created.
			WorkspaceChecker checker = new WorkspaceChecker();
			checker.run(new NullProgressMonitor());
			
			int returnCode = PlatformUI.createAndRunWorkbench(display, new ApplicationWorkbenchAdvisor());
			
			if (returnCode != PlatformUI.RETURN_RESTART) {
				return EXIT_OK;
			}

            // if the exit code property has been set to the relaunch code, then
            // return that code now, otherwise this is a normal restart
            return EXIT_RELAUNCH.equals(Integer.getInteger(PROP_EXIT_CODE)) ? EXIT_RELAUNCH : EXIT_RESTART;
		} finally {
			display.dispose();
            Location instanceLoc = Platform.getInstanceLocation();
            if (instanceLoc != null)
            	instanceLoc.release();
		}
		
	}

	/* (non-Javadoc)
	 * @see org.eclipse.equinox.app.IApplication#stop()
	 */
	public void stop() {
		if (!PlatformUI.isWorkbenchRunning())
			return;
		final IWorkbench workbench = PlatformUI.getWorkbench();
		final Display display = workbench.getDisplay();
		display.syncExec(new Runnable() {
			public void run() {
				if (!display.isDisposed())
					workbench.close();
			}
		});
	}
}
