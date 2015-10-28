package eu.openanalytics.architect.ui;

import org.eclipse.jface.preference.PreferencePage;
import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.Label;
import org.eclipse.ui.IWorkbench;
import org.eclipse.ui.IWorkbenchPreferencePage;

public class ArchitectPreferencePage extends PreferencePage implements IWorkbenchPreferencePage {

	@Override
	public void init(IWorkbench workbench) {
		// Nothing to do.
	}

	@Override
	protected Control createContents(Composite parent) {
		Label lbl = new Label(parent, SWT.NONE);
		lbl.setText("See sub-pages for settings.");
		return lbl;
	}

}
