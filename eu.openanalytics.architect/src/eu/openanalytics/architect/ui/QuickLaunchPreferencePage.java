package eu.openanalytics.architect.ui;

import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.Status;
import org.eclipse.debug.core.DebugPlugin;
import org.eclipse.debug.core.ILaunchConfiguration;
import org.eclipse.debug.core.ILaunchManager;
import org.eclipse.debug.ui.DebugUITools;
import org.eclipse.debug.ui.IDebugUIConstants;
import org.eclipse.jface.layout.GridDataFactory;
import org.eclipse.jface.layout.GridLayoutFactory;
import org.eclipse.jface.preference.PreferencePage;
import org.eclipse.jface.viewers.ArrayContentProvider;
import org.eclipse.jface.viewers.CellLabelProvider;
import org.eclipse.jface.viewers.ISelectionChangedListener;
import org.eclipse.jface.viewers.SelectionChangedEvent;
import org.eclipse.jface.viewers.StructuredSelection;
import org.eclipse.jface.viewers.TableViewer;
import org.eclipse.jface.viewers.TableViewerColumn;
import org.eclipse.jface.viewers.ViewerCell;
import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.Label;
import org.eclipse.ui.IWorkbench;
import org.eclipse.ui.IWorkbenchPreferencePage;
import org.eclipse.ui.dialogs.PreferenceLinkArea;
import org.eclipse.ui.preferences.IWorkbenchPreferenceContainer;

import eu.openanalytics.architect.Activator;

public class QuickLaunchPreferencePage extends PreferencePage implements IWorkbenchPreferencePage {

	private static final String[][] LAUNCH_MAPPINGS = {
			{ "My favorite Debug Configuration", QuickLaunchCommandHandler.LAUNCH_MAPPING_FAVORITE_DEBUG },
			{ "My favorite Run Configuration", QuickLaunchCommandHandler.LAUNCH_MAPPING_FAVORITE_RUN},
			{ "My favorite External Tool Configuration", QuickLaunchCommandHandler.LAUNCH_MAPPING_FAVORITE_EXT },
			{ "This launch configuration:", QuickLaunchCommandHandler.LAUNCH_MAPPING_OTHER }
	};

	private Button[] radioButtons;
	private TableViewer tableViewer;
	
	@Override
	public void init(IWorkbench workbench) {
		// Nothing to do.
	}

	@Override
	protected Control createContents(Composite parent) {
		Composite area = new Composite(parent, SWT.NONE);
		GridLayoutFactory.fillDefaults().margins(0, 0).applyTo(area);
		
		new PreferenceLinkArea(area, SWT.NONE,
				"org.eclipse.ui.preferencePages.Keys",
				"Key binding: see the <a>''{0}''</a> page",
				(IWorkbenchPreferenceContainer) getContainer(),
				null);
		
		Label lbl = new Label(area, SWT.NONE);
		lbl.setText("Mapped launch:");
		
		radioButtons = new Button[LAUNCH_MAPPINGS.length];
		for (int i = 0; i < radioButtons.length; i++) {
			radioButtons[i] = new Button(area, SWT.RADIO);
			radioButtons[i].setText(LAUNCH_MAPPINGS[i][0]);
		}
		
		tableViewer = new TableViewer(area, SWT.BORDER | SWT.FULL_SELECTION);
		tableViewer.setContentProvider(new ArrayContentProvider());
		tableViewer.addSelectionChangedListener(new ISelectionChangedListener() {
			@Override
			public void selectionChanged(SelectionChangedEvent event) {
				for (int i = 0; i < radioButtons.length; i++) {
					radioButtons[i].setSelection(i == radioButtons.length - 1);
				}
			}
		});
		GridDataFactory.fillDefaults().indent(20, 0).grab(true, true).applyTo(tableViewer.getControl());
		
		TableViewerColumn col = new TableViewerColumn(tableViewer, SWT.NONE);
		col.setLabelProvider(new CellLabelProvider() {
			@Override
			public void update(ViewerCell cell) {
				ILaunchConfiguration cfg = (ILaunchConfiguration) cell.getElement();
				String mode = IDebugUIConstants.IMG_ACT_RUN;
				try {
					if (cfg.supportsMode(ILaunchManager.DEBUG_MODE)) mode = IDebugUIConstants.IMG_ACT_DEBUG;
				} catch (CoreException e) {}
				cell.setImage(DebugUITools.getImage(mode));
			}
		});
		col.getColumn().setWidth(25);
		
		col = new TableViewerColumn(tableViewer, SWT.NONE);
		col.setLabelProvider(new CellLabelProvider() {
			@Override
			public void update(ViewerCell cell) {
				ILaunchConfiguration cfg = (ILaunchConfiguration) cell.getElement();
				try {
					cell.setImage(DebugUITools.getImage(cfg.getType().getIdentifier()));
					cell.setText(cfg.getName());
				} catch (CoreException e) {}
			}
		});
		col.getColumn().setWidth(200);
		
		ILaunchManager lm = DebugPlugin.getDefault().getLaunchManager();
		try {
			tableViewer.setInput(lm.getLaunchConfigurations());
		} catch (CoreException e) {
			Activator.getDefault().getLog().log(new Status(IStatus.ERROR, Activator.PLUGIN_ID, "Failed to retrieve launch configs", e));
		}
		
		applyCurrentPrefValues();
		
		return area;
	}

	private void applyCurrentPrefValues() {
		String currentLaunchMapping = QuickLaunchPreferences.getStore().getString(QuickLaunchPreferences.PREF_LAUNCH_MAPPING);
		for (int i = 0; i < radioButtons.length; i++) {
			radioButtons[i].setSelection(LAUNCH_MAPPINGS[i][1].equals(currentLaunchMapping));
		}
		String currentLaunchName = QuickLaunchPreferences.getStore().getString(QuickLaunchPreferences.PREF_LAUNCH_NAME);
		if (currentLaunchName != null && radioButtons[3].getSelection()) {
			ILaunchConfiguration config = null;
			ILaunchConfiguration[] configs = (ILaunchConfiguration[]) tableViewer.getInput();
			for (int i = 0; i < configs.length; i++) {
				if (configs[i].getName().equals(currentLaunchName)) config = configs[i];
			}
			if (config != null) tableViewer.setSelection(new StructuredSelection(config));
		}
	}
	
	@Override
	protected void performDefaults() {
		QuickLaunchPreferences.getStore().setToDefault(QuickLaunchPreferences.PREF_LAUNCH_MAPPING);
		QuickLaunchPreferences.getStore().setToDefault(QuickLaunchPreferences.PREF_LAUNCH_NAME);
		applyCurrentPrefValues();
		super.performDefaults();
	}
	
	@Override
	public boolean performOk() {
		for (int i = 0; i < radioButtons.length; i++) {
			if (radioButtons[i].getSelection())
				QuickLaunchPreferences.getStore().setValue(QuickLaunchPreferences.PREF_LAUNCH_MAPPING, LAUNCH_MAPPINGS[i][1]);
		}
		if (radioButtons[3].getSelection()) {
			ILaunchConfiguration config = (ILaunchConfiguration) tableViewer.getStructuredSelection().getFirstElement();
			QuickLaunchPreferences.getStore().setValue(QuickLaunchPreferences.PREF_LAUNCH_NAME, config.getName());
		}
		return super.performOk();
	}
}