package eu.openanalytics.architect.ui;

import java.nio.file.Files;
import java.nio.file.Paths;

import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.Status;
import org.eclipse.debug.core.ILaunch;
import org.eclipse.debug.core.ILaunchConfiguration;
import org.eclipse.debug.core.ILaunchConfigurationWorkingCopy;
import org.eclipse.swt.widgets.Display;
import org.eclipse.ui.IViewPart;
import org.eclipse.ui.IWorkbenchPage;
import org.eclipse.ui.IWorkbenchWindow;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.console.ConsolePlugin;
import org.eclipse.ui.console.IConsole;
import org.eclipse.ui.console.IConsoleView;

import de.walware.statet.nico.core.runtime.ToolWorkspace;
import de.walware.statet.r.console.core.RProcess;
import de.walware.statet.r.console.ui.RConsole;
import eu.openanalytics.architect.Activator;

public class RestartRCommandHandler extends AbstractHandler  {

	@Override
	public Object execute(ExecutionEvent event) throws ExecutionException {
		RConsole rConsole = null;
		IWorkbenchWindow window= PlatformUI.getWorkbench().getActiveWorkbenchWindow();
        if (window != null) {
            IWorkbenchPage page= window.getActivePage();
            if (page != null) {
            	IViewPart view = page.findView("org.eclipse.ui.console.ConsoleView");
            	IConsole console = null;
            	if (view instanceof IConsoleView) console = ((IConsoleView) view).getConsole();
            	if (console instanceof RConsole) rConsole = (RConsole) console;
            }
        }
		if (rConsole == null) return null;
		
		final RConsole consoleToRestart = rConsole;
		final ILaunch launch = ((RProcess) rConsole.getProcess()).getLaunch();
		
		ToolWorkspace ws = consoleToRestart.getProcess().getWorkspaceData();
		String wd = ws.getWorkspaceDir().toString();
		
		Display.getDefault().asyncExec(new SessionRestarter(consoleToRestart, launch, wd));
		return null;
	}

	private static class SessionRestarter implements Runnable {
		
		private RConsole console;
		private ILaunch launch;
		private String wd;
		
		public SessionRestarter(RConsole console, ILaunch launch, String wd) {
			this.console = console;
			this.launch = launch;
			this.wd = wd;
		}
		
		@Override
		public void run() {
			String launchMode = launch.getLaunchMode();
			ILaunchConfiguration launchConfig = launch.getLaunchConfiguration();
			try {
				launch.terminate();
				while (!launch.isTerminated()) {
					if (!Display.getCurrent().readAndDispatch()) Display.getCurrent().sleep();
				}
				
				ConsolePlugin.getDefault().getConsoleManager().removeConsoles(new IConsole[] {console});
				ILaunchConfigurationWorkingCopy wc = launchConfig.getWorkingCopy();
				if (Files.exists(Paths.get(wd))) {
					wc.setAttribute("de.walware.statet.r.debug/REnv/workingDirectory", wd);
					wc.setAttribute("de.walware.statet.r/renv/WorkingDirectory", wd);
				} else {
					String msg = "Restarting in default directory because previous working directory no longer exists: " + wd;
					Activator.getDefault().getLog().log(new Status(IStatus.WARNING, Activator.PLUGIN_ID, msg));
				}
				wc.launch(launchMode, null);
			} catch (CoreException e) {
				Activator.getDefault().getLog().log(new Status(IStatus.ERROR, Activator.PLUGIN_ID, "Failed to restart R session", e));
			}
		}
	}
}
