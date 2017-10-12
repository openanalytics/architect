package eu.openanalytics.architect.rmi;

import org.eclipse.core.runtime.CoreException;
import org.eclipse.debug.core.ILaunchConfiguration;
import org.eclipse.debug.core.ILaunchConfigurationWorkingCopy;
import org.eclipse.debug.ui.AbstractLaunchConfigurationTab;
import org.eclipse.jface.layout.GridDataFactory;
import org.eclipse.jface.layout.GridLayoutFactory;
import org.eclipse.swt.SWT;
import org.eclipse.swt.events.ModifyEvent;
import org.eclipse.swt.events.ModifyListener;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Text;

public class WebSocketRConsoleLaunchMainTab extends AbstractLaunchConfigurationTab {

	private Text addressTxt;
	private Text usernameTxt;
	private Text passwordTxt;
	
	@Override
	public void createControl(Composite parent) {
		Composite main = new Composite(parent, SWT.NONE);
		GridDataFactory.fillDefaults().grab(true, true).applyTo(main);
		GridLayoutFactory.fillDefaults().numColumns(2).margins(5, 5).applyTo(main);
		
		ModifyListener l = new ModifyListener() {
			@Override
			public void modifyText(ModifyEvent e) {
				setDirty(true);
				updateLaunchConfigurationDialog();
			}
		};
		
		new Label(main, SWT.NONE).setText("Address:");
		addressTxt = new Text(main, SWT.BORDER);
		addressTxt.addModifyListener(l);
		GridDataFactory.fillDefaults().grab(true, false).applyTo(addressTxt);

		new Label(main, SWT.NONE).setText("Username:");
		usernameTxt = new Text(main, SWT.BORDER);
		usernameTxt.addModifyListener(l);
		GridDataFactory.fillDefaults().grab(true, false).applyTo(usernameTxt);
		
		new Label(main, SWT.NONE).setText("Password:");
		passwordTxt = new Text(main, SWT.BORDER | SWT.PASSWORD);
		passwordTxt.addModifyListener(l);
		GridDataFactory.fillDefaults().grab(true, false).applyTo(passwordTxt);
		
		setControl(main);
	}

	@Override
	public void setDefaults(ILaunchConfigurationWorkingCopy configuration) {
		configuration.setAttribute(WebSocketRConsoleLaunchDelegate.ATTR_ADDRESS, "http://localhost:8080");
		configuration.setAttribute(WebSocketRConsoleLaunchDelegate.ATTR_USERNAME, "");
		configuration.setAttribute(WebSocketRConsoleLaunchDelegate.ATTR_PASSWORD, "");
	}

	@Override
	public void initializeFrom(ILaunchConfiguration configuration) {
		try {
			addressTxt.setText(configuration.getAttribute(WebSocketRConsoleLaunchDelegate.ATTR_ADDRESS, ""));
			usernameTxt.setText(configuration.getAttribute(WebSocketRConsoleLaunchDelegate.ATTR_USERNAME, ""));
			passwordTxt.setText(configuration.getAttribute(WebSocketRConsoleLaunchDelegate.ATTR_PASSWORD, ""));
		} catch (CoreException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void performApply(ILaunchConfigurationWorkingCopy configuration) {
		configuration.setAttribute(WebSocketRConsoleLaunchDelegate.ATTR_ADDRESS, addressTxt.getText());
		configuration.setAttribute(WebSocketRConsoleLaunchDelegate.ATTR_USERNAME, usernameTxt.getText());
		configuration.setAttribute(WebSocketRConsoleLaunchDelegate.ATTR_PASSWORD, passwordTxt.getText());
	}

	@Override
	public String getName() {
		return "Main";
	}

}
