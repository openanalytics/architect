package eu.openanalytics.architect.rmi;

import org.eclipse.debug.ui.AbstractLaunchConfigurationTabGroup;
import org.eclipse.debug.ui.ILaunchConfigurationDialog;
import org.eclipse.debug.ui.ILaunchConfigurationTab;

public class WebSocketRConsoleLaunchTabGroup extends AbstractLaunchConfigurationTabGroup {

	@Override
	public void createTabs(ILaunchConfigurationDialog dialog, String mode) {
		final ILaunchConfigurationTab[] tabs= new ILaunchConfigurationTab[] {
				new WebSocketRConsoleLaunchMainTab()
		};
		setTabs(tabs);
	}

}
