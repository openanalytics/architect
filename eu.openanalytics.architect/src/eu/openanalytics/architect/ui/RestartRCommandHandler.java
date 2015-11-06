package eu.openanalytics.architect.ui;

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
import org.eclipse.ui.console.ConsolePlugin;
import org.eclipse.ui.console.IConsole;
import org.eclipse.ui.console.IConsoleManager;

import de.walware.statet.nico.core.runtime.ToolWorkspace;
import de.walware.statet.r.console.core.RProcess;
import de.walware.statet.r.console.ui.RConsole;
import eu.openanalytics.architect.Activator;

public class RestartRCommandHandler extends AbstractHandler  {

	@Override
	public Object execute(ExecutionEvent event) throws ExecutionException {
		// Get the current R session (and its launch config)
		IConsoleManager consoleMgr = ConsolePlugin.getDefault().getConsoleManager();
		IConsole[] consoles = consoleMgr.getConsoles();
		RConsole rConsole = null;
		for (int i = 0; i < consoles.length; i++) {
			if (consoles[i] instanceof RConsole) {
				rConsole = (RConsole) consoles[i];
				break;
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
				wc.setAttribute("de.walware.statet.r.debug/REnv/workingDirectory", wd);
				wc.setAttribute("de.walware.statet.r/renv/WorkingDirectory", wd);
				wc.launch(launchMode, null);
			} catch (CoreException e) {
				Activator.getDefault().getLog().log(new Status(IStatus.ERROR, Activator.PLUGIN_ID, "Failed to restart R session", e));
			}
		}
	}
}
