package eu.openanalytics.architect.ui;

import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.Status;
import org.eclipse.debug.core.DebugPlugin;
import org.eclipse.debug.core.ILaunchConfiguration;
import org.eclipse.debug.core.ILaunchManager;

import eu.openanalytics.architect.Activator;

public class QuickLaunchCommandHandler extends AbstractHandler  {

	public static final String LAUNCH_MAPPING_FAVORITE_DEBUG = "favoriteDebug";
	public static final String LAUNCH_MAPPING_FAVORITE_RUN = "favoriteRun";
	public static final String LAUNCH_MAPPING_FAVORITE_EXT = "favoriteExternal";
	public static final String LAUNCH_MAPPING_OTHER = "other";

	public Object execute(ExecutionEvent event) throws ExecutionException {
		String currentLaunchMapping = QuickLaunchPreferences.getStore().getString(QuickLaunchPreferences.PREF_LAUNCH_MAPPING);
		String currentLaunchName = QuickLaunchPreferences.getStore().getString(QuickLaunchPreferences.PREF_LAUNCH_NAME);
		
		ILaunchConfiguration configToLaunch = null;
		ILaunchManager lm = DebugPlugin.getDefault().getLaunchManager();
		
		try {
			//TODO Support all mappings
			if (LAUNCH_MAPPING_OTHER.equals(currentLaunchMapping)) {
				ILaunchConfiguration[] configs = lm.getLaunchConfigurations();
				for (int i = 0; i < configs.length; i++) {
					if (configs[i].getName().equals(currentLaunchName)) configToLaunch = configs[i];
				}
			}
			
			if (configToLaunch == null) {
				Activator.getDefault().getLog().log(new Status(IStatus.WARNING, Activator.PLUGIN_ID, "Quick Launch: no launch mapping found."));
			} else {
				String mode = ILaunchManager.RUN_MODE;
				if (configToLaunch.supportsMode(ILaunchManager.DEBUG_MODE)) mode = ILaunchManager.DEBUG_MODE;
				configToLaunch.launch(mode, null);
			}
		} catch (CoreException e) {
			Activator.getDefault().getLog().log(new Status(IStatus.ERROR, Activator.PLUGIN_ID, "Failed to retrieve launch configs", e));
		}

		return null;
	}
}
