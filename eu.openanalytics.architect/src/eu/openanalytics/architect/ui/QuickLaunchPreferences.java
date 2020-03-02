package eu.openanalytics.architect.ui;

import org.eclipse.core.runtime.preferences.AbstractPreferenceInitializer;
import org.eclipse.jface.preference.IPreferenceStore;

import eu.openanalytics.architect.Activator;

public class QuickLaunchPreferences extends AbstractPreferenceInitializer {

	public static final String PREF_LAUNCH_MAPPING = "LAUNCH_MAPPING";
	public static final String PREF_LAUNCH_NAME = "LAUNCH_NAME";
	
	@Override
	public void initializeDefaultPreferences() {
		getStore().setDefault(PREF_LAUNCH_MAPPING, QuickLaunchCommandHandler.LAUNCH_MAPPING_FAVORITE_DEBUG);
//		getStore().setDefault(PREF_LAUNCH_NAME, null);
	}
	
	public static IPreferenceStore getStore() {
		return Activator.getDefault().getPreferenceStore();
	}
}
