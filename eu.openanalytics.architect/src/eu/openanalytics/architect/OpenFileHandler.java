package eu.openanalytics.architect;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.eclipse.core.filesystem.EFS;
import org.eclipse.core.filesystem.IFileStore;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.NullProgressMonitor;
import org.eclipse.core.runtime.Path;
import org.eclipse.core.runtime.Status;
import org.eclipse.osgi.service.environment.EnvironmentInfo;
import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Event;
import org.eclipse.swt.widgets.Listener;
import org.eclipse.ui.IWorkbenchPage;
import org.eclipse.ui.IWorkbenchWindow;
import org.eclipse.ui.PartInitException;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.ide.IDE;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;

import de.walware.statet.r.launching.RCodeLaunching;

public class OpenFileHandler implements Listener {
	
	private final static String[] DATA_FILE_EXTS = {".rdata", ".rda"};
	
	private List<String> filesToOpen = new ArrayList<String>();
	
	public OpenFileHandler(Display display) {
		display.addListener(SWT.OpenDocument, this);
		
		// If the program started with a file argument, open it now.
		BundleContext ctx = Activator.getDefault().getBundle().getBundleContext();
		ServiceReference<?> infoRef = ctx.getServiceReference(EnvironmentInfo.class.getName());
		if (infoRef != null) {
			EnvironmentInfo envInfo = (EnvironmentInfo)ctx.getService(infoRef);
			String[] args = envInfo.getCommandLineArgs();
			for (String arg: args) {
				File testFile = new File(arg);
				if (testFile.isFile()) {
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
		filesToOpen.add(path);
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
		String safePath = path.toLowerCase().replace('\\', '/');
		for (String ext: DATA_FILE_EXTS) {
			if (safePath.endsWith(ext)) {
				new DelayedLoad(safePath, 1000, 20).run();
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
		private int timeout;
		private int currentTry;
		private int maxTries;
		
		public DelayedLoad(String path, int timeout, int maxTries) {
			this.path = path;
			this.timeout = timeout;
			this.maxTries = maxTries;
			this.currentTry = 1;
		}
		
		@Override
		public void run() {
			try {
				String[] lines = {"load('" + path + "')"};
				RCodeLaunching.runRCodeDirect(lines, true, new NullProgressMonitor());
			} catch (CoreException e) {
				// Still no active session...
				if (currentTry < maxTries) {
					currentTry++;
					Display.getDefault().timerExec(timeout, this);
				} else {
					Activator.getDefault().getLog().log(new Status(IStatus.ERROR, Activator.PLUGIN_ID, "Cannot load " + path + ": " + e.getMessage()));
				}
			}
		}
	}
}
