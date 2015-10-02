package eu.openanalytics.architect.ui;

import java.util.ArrayList;
import java.util.List;

import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.NullProgressMonitor;
import org.eclipse.core.runtime.Status;
import org.eclipse.debug.core.ILaunch;
import org.eclipse.debug.core.ILaunchConfiguration;
import org.eclipse.jface.text.DocumentEvent;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.IDocumentListener;
import org.eclipse.swt.widgets.Display;
import org.eclipse.ui.console.ConsolePlugin;
import org.eclipse.ui.console.IConsole;
import org.eclipse.ui.console.IConsoleManager;

import de.walware.statet.r.console.core.RProcess;
import de.walware.statet.r.console.ui.RConsole;
import de.walware.statet.r.launching.RCodeLaunching;
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
		final IDocument doc = rConsole.getDocument();
		
		// Get session's working directory
		//TODO Find a better way to get this information out of R
		IDocumentListener listener = new IDocumentListener() {
			@Override
			public void documentChanged(DocumentEvent event) {
				String text = event.getText();
				String wd = text.substring(text.indexOf("[1]") + 4).trim();
				if (wd.contains("\"")) wd = wd.substring(1, wd.length() - 1);
				doc.removeDocumentListener(this);
				Display.getDefault().asyncExec(new SessionRestarter(consoleToRestart, launch, wd));
			}
			@Override
			public void documentAboutToBeChanged(DocumentEvent event) {
				// Do nothing.
			}
		};
		doc.addDocumentListener(listener);

		try {
			submitToConsole("getwd()");
		} catch (CoreException e) {
			doc.removeDocumentListener(listener);
			Activator.getDefault().getLog().log(new Status(IStatus.ERROR, Activator.PLUGIN_ID, "Failed to restart R session", e));
		}

		return null;
	}

	private static void submitToConsole(String input) throws CoreException {
		List<String> lineList = new ArrayList<String>();
		lineList.add(input);
		RCodeLaunching.runRCodeDirect(lineList, true, new NullProgressMonitor());
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
				launchConfig.launch(launchMode, null);
				new RetryingCmd("setwd('" + wd + "')").run();
			} catch (CoreException e) {
				Activator.getDefault().getLog().log(new Status(IStatus.ERROR, Activator.PLUGIN_ID, "Failed to restart R session", e));
			}
		}
	}
	
	private static class RetryingCmd implements Runnable {
		
		private String cmd;
		private int currentTry;
		private int maxTries = 8;
		private int timeout = 2000;
		
		public RetryingCmd(String cmd) {
			this.cmd = cmd;
			this.currentTry = 1;
		}
		
		@Override
		public void run() {
			try {
				submitToConsole(cmd);
			} catch (CoreException e) {
				if (currentTry < maxTries) {
					currentTry++;
					Display.getDefault().timerExec(timeout, this);
				} else {
					Activator.getDefault().getLog().log(new Status(IStatus.ERROR, Activator.PLUGIN_ID, "Cannot execute " + cmd, e));
				}
			}
		}
	}
}
