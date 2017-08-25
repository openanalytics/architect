package eu.openanalytics.architect;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.eclipse.core.filesystem.EFS;
import org.eclipse.core.filesystem.IFileStore;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.NullProgressMonitor;
import org.eclipse.core.runtime.Path;
import org.eclipse.core.runtime.Status;
import org.eclipse.core.runtime.preferences.IEclipsePreferences;
import org.eclipse.core.runtime.preferences.InstanceScope;
import org.eclipse.debug.core.DebugPlugin;
import org.eclipse.debug.core.ILaunchConfiguration;
import org.eclipse.debug.core.ILaunchManager;
import org.eclipse.osgi.service.environment.EnvironmentInfo;
import org.eclipse.statet.r.launching.RCodeLaunching;
import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Event;
import org.eclipse.swt.widgets.Listener;
import org.eclipse.ui.IWorkbenchPage;
import org.eclipse.ui.IWorkbenchWindow;
import org.eclipse.ui.PartInitException;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.ide.IDE;
import org.eclipse.ui.statushandlers.StatusManager;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;

public class OpenFileHandler implements Listener {
	
	private final static String[] DATA_FILE_EXTS = {".rdata", ".rda"};
	
	private List<String> filesToOpen = new ArrayList<String>();
	private String openFileArg = null;
	
	public OpenFileHandler(Display display) {
		display.addListener(SWT.OpenDocument, this);
		
		// If the program started with a file argument, open it now.
		BundleContext ctx = Activator.getDefault().getBundle().getBundleContext();
		ServiceReference<?> infoRef = ctx.getServiceReference(EnvironmentInfo.class.getName());
		if (infoRef != null) {
			EnvironmentInfo envInfo = (EnvironmentInfo)ctx.getService(infoRef);
			String[] args = envInfo.getCommandLineArgs();
			for (String arg: args) {
				if (new File(arg).isFile()) {
					openFileArg = arg.replace('\\', '/');
					Event event = new Event();
					event.text = arg;
					handleEvent(event);
				}
			}
		}
	}
	
	@Override
	public void handleEvent(Event event) {
		String path = event.text;
		if (!filesToOpen.contains(path)) filesToOpen.add(path);
	}
	
	public void catchUp(Display display) {
		if (filesToOpen.isEmpty()) return;
		
		String[] paths = new String[filesToOpen.size()];
		filesToOpen.toArray(paths);
		filesToOpen.clear();
		
		for (int i = 0; i < paths.length; i++) {
			openFile(display, paths[i]);
		}
	}
	
	private void openFile(Display display, String path) {
		IFileStore fileStore = EFS.getLocalFileSystem().getStore(new Path(path));
		IWorkbenchWindow window = PlatformUI.getWorkbench().getActiveWorkbenchWindow();

		if (window == null || window.getActivePage() == null) {
			IStatus status = new Status(IStatus.WARNING, Activator.PLUGIN_ID, "Failed to open file: no active workbench window or page.");
			Activator.getDefault().getLog().log(status);
			return;
		}
		
		// If it's a data file, attempt to load it in an active console.
		String safePath = path.replace('\\', '/');
		for (String ext: DATA_FILE_EXTS) {
			if (safePath.toLowerCase().endsWith(ext)) {
				new DelayedLoad(safePath, true).run();
				return;
			}
		}
		
		// Else, attempt to open an editor that is appropriate for the file type.
		IWorkbenchPage page = window.getActivePage();
		try {
			IDE.openEditorOnFileStore(page, fileStore);
		} catch (PartInitException e) {
			IStatus status = new Status(IStatus.ERROR, Activator.PLUGIN_ID, "Failed to open file: " + e.getMessage(), e);
			Activator.getDefault().getLog().log(status);
		}
	}
	
	private class DelayedLoad implements Runnable {
		
		private String path;
		private int currentTry;
		private boolean allowConsoleLaunch;
		private int maxTries = 8;
		private int timeout = 2000;
		
		public DelayedLoad(String path, boolean allowConsoleLaunch) {
			this.path = path;
			this.currentTry = 1;
			this.allowConsoleLaunch = allowConsoleLaunch;
		}
		
		@Override
		public void run() {
			try {
				String parentPath = new File(path).getParentFile().getAbsolutePath().replace('\\', '/');
				List<String> lineList = new ArrayList<String>();
				lineList.add("setwd('" + parentPath + "')");
				lineList.add("load('" + path + "')");
				RCodeLaunching.runRCodeDirect(lineList, true, new NullProgressMonitor());
				throw new CoreException(new Status(IStatus.ERROR, Activator.PLUGIN_ID, "TODO implement"));
			} catch (CoreException e) {
				boolean isOpenFileArg = path.equals(openFileArg);
				if (isOpenFileArg) openFileArg = null; // Do this test only once.
				
				// Option 1: Architect was already running, but there's no active console.
				if (!isOpenFileArg && allowConsoleLaunch) {
					launchConsole(new NullProgressMonitor());
					new DelayedLoad(path, false).run();
					return;
				}
				
				// Option 2: Architect is just starting up, without autorun
				if (isOpenFileArg && !isAutoRunEnabled() && allowConsoleLaunch) {
					launchConsole(new NullProgressMonitor());
					new DelayedLoad(path, false).run();
					return;
				}
				
				// Option 3: A console is underway, need some patience
				if (currentTry < maxTries) {
					currentTry++;
					Display.getDefault().timerExec(timeout, this);
				} else {
					// All tries have been exhausted. Give up and log an error.
					Activator.getDefault().getLog().log(new Status(IStatus.ERROR, Activator.PLUGIN_ID, "Cannot load " + path + ": " + e.getMessage()));
				}
			}
		}
		
		private boolean isAutoRunEnabled() {
			IEclipsePreferences node = getAutoRunPreferences();
			String isEnabledString = node.get("enabled", "false");
			return Boolean.valueOf(isEnabledString);
		}
		
		private IStatus launchConsole(final IProgressMonitor monitor) {
			IEclipsePreferences node = getAutoRunPreferences();
			String key = node.get("config.id", null);
			String mode = null;
			if (key != null) mode = node.get("mode.id", ILaunchManager.RUN_MODE);
			if (mode != null) {
				try {
					final ILaunchConfiguration config = DebugPlugin.getDefault().getLaunchManager().getLaunchConfiguration(key);
					if (config == null) {
						final IStatus status = new Status(IStatus.WARNING, Activator.PLUGIN_ID, 101,
								"The configured launch configuration for Auto-Run could not be loaded.", null);
						StatusManager.getManager().handle(status);
						return Status.OK_STATUS;
					}
					config.launch(mode, monitor, false, true);
				}
				catch (final CoreException e) {
					final IStatus status = new Status(IStatus.ERROR, Activator.PLUGIN_ID, 102, 
							"An error occured when starting the launch configuration by Auto-Run.", e);
					return status;
				}
				return Status.OK_STATUS;
			}
			return Status.CANCEL_STATUS;
		}
		
		@SuppressWarnings("deprecation")
		private IEclipsePreferences getAutoRunPreferences() {
			return new InstanceScope().getNode("de.walware.eutils.autorun");
		}
	}
}
