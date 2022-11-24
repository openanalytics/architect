package eu.openanalytics.architect.ui;

import org.eclipse.core.expressions.PropertyTester;
import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.Status;
import org.eclipse.ui.console.IConsole;
import org.eclipse.ui.console.IConsoleView;

import eu.openanalytics.architect.Activator;

public class ActiveConsoleTester extends PropertyTester {

	private static final String ACTIVE_CONSOLE = "activeConsole";

	@Override
	public boolean test(Object receiver, String property, Object[] args, Object expectedValue) {
		if (ACTIVE_CONSOLE.equals(property) && receiver instanceof IConsoleView) {
			try {
				IConsole console = ((IConsoleView) receiver).getConsole();
				Class<?> clazz = Class.forName(expectedValue.toString());
				if (console != null && clazz != null) return (clazz.isAssignableFrom(console.getClass()));
			} catch (ClassNotFoundException e) {
				Activator.getDefault().getLog().log(new Status(IStatus.ERROR, Activator.PLUGIN_ID, "Failed to resolve console class: " + expectedValue, e));
			}
		}
		return false;
	}
}
