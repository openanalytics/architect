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
import org.eclipse.debug.internal.ui.DebugUIPlugin;
import org.eclipse.debug.internal.ui.launchConfigurations.LaunchConfigurationManager;
import org.eclipse.debug.ui.IDebugUIConstants;

import eu.openanalytics.architect.Activator;

@SuppressWarnings("restriction")
public class QuickLaunchCommandHandler extends AbstractHandler  {

	public static final String LAUNCH_MAPPING_FAVORITE_DEBUG = "favoriteDebug";
	public static final String LAUNCH_MAPPING_FAVORITE_RUN = "favoriteRun";
	public static final String LAUNCH_MAPPING_FAVORITE_EXT = "favoriteExternal";
	public static final String LAUNCH_MAPPING_OTHER = "other";

	private static final String ID_EXT_TOOLS_LAUNCH_GROUP = "org.eclipse.ui.externaltools.launchGroup";
	
	public Object execute(ExecutionEvent event) throws ExecutionException {
		ILaunchConfiguration configToLaunch = null;
		
		ILaunchManager lm = DebugPlugin.getDefault().getLaunchManager();
		LaunchConfigurationManager lcm = DebugUIPlugin.getDefault().getLaunchConfigurationManager();
		
		try {
			String currentLaunchMapping = QuickLaunchPreferences.getStore().getString(QuickLaunchPreferences.PREF_LAUNCH_MAPPING);
			
			// Find the appropriate launch configuration, according to the Launch Mapping preference
			if (LAUNCH_MAPPING_FAVORITE_DEBUG.equals(currentLaunchMapping)) {
				ILaunchConfiguration[] configs = lcm.getLaunchHistory(IDebugUIConstants.ID_DEBUG_LAUNCH_GROUP).getFavorites();
				if (configs.length > 0) configToLaunch = configs[0];
			} else if (LAUNCH_MAPPING_FAVORITE_RUN.equals(currentLaunchMapping)) {
				ILaunchConfiguration[] configs = lcm.getLaunchHistory(IDebugUIConstants.ID_RUN_LAUNCH_GROUP).getFavorites();
				if (configs.length > 0) configToLaunch = configs[0];
			} else if (LAUNCH_MAPPING_FAVORITE_EXT.equals(currentLaunchMapping)) {
				ILaunchConfiguration[] configs = lcm.getLaunchHistory(ID_EXT_TOOLS_LAUNCH_GROUP).getFavorites();
				if (configs.length > 0) configToLaunch = configs[0];
			} else if (LAUNCH_MAPPING_OTHER.equals(currentLaunchMapping)) {
				String currentLaunchName = QuickLaunchPreferences.getStore().getString(QuickLaunchPreferences.PREF_LAUNCH_NAME);
				ILaunchConfiguration[] configs = lm.getLaunchConfigurations();
				for (int i = 0; i < configs.length; i++) {
					if (configs[i].getName().equals(currentLaunchName)) configToLaunch = configs[i];
				}
			}
			
			// Attempt to launch the selected launch configuration
			if (configToLaunch == null) {
				Activator.getDefault().getLog().log(new Status(IStatus.WARNING, Activator.PLUGIN_ID, "Quick launch aborted: no launch mapping found."));
			} else {
				String mode = ILaunchManager.RUN_MODE;
				if (configToLaunch.supportsMode(ILaunchManager.DEBUG_MODE)) mode = ILaunchManager.DEBUG_MODE;
				configToLaunch.launch(mode, null);
			}
		} catch (CoreException e) {
			Activator.getDefault().getLog().log(new Status(IStatus.ERROR, Activator.PLUGIN_ID, "Failed to quick launch " + configToLaunch, e));
		}

		return null;
	}
	
}
