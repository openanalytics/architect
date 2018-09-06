package eu.openanalytics.arichitect.r.tests;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swtbot.eclipse.finder.SWTWorkbenchBot;
import org.eclipse.swtbot.eclipse.finder.widgets.SWTBotEclipseEditor;
import org.eclipse.swtbot.eclipse.finder.widgets.SWTBotView;
import org.eclipse.swtbot.swt.finder.waits.WaitForObjectCondition;
import org.eclipse.swtbot.swt.finder.widgets.SWTBotShell;
import org.eclipse.swtbot.swt.finder.widgets.SWTBotStyledText;
import org.eclipse.swtbot.swt.finder.widgets.SWTBotTable;
import org.eclipse.swtbot.swt.finder.widgets.SWTBotToolbarButton;
import org.eclipse.swtbot.swt.finder.widgets.SWTBotTreeItem;
import org.junit.BeforeClass;
import org.junit.Test;

public class ArchitectTests {

	private static String PROJECT_NAME = "testProject";
	private static String PROJECT_PATH = "./workspace/" + PROJECT_NAME;
	private static String TEST_FILE_NAME = "test.txt";

	private static SWTWorkbenchBot bot;
	private static String resolvedWorkspacePath;
	
	private static SWTBotView view;
	private static SWTBotStyledText text;

	@BeforeClass
	public static void beforeClass() {
		bot = new SWTWorkbenchBot();
		SWTBotShell wb = bot.activeShell();
		wb.activate();
		try {Thread.sleep(500000);} catch (InterruptedException e) {}
		// TODO wait until console view has a page for R
		view = bot.viewById("org.eclipse.ui.console.ConsoleView");
		text = view.bot().styledText();
	}

	@Test
	public void consoleTest() {
		text.typeText("2+2\n");
		try {Thread.sleep(2000);} catch (InterruptedException e) {}
		assertTrue(text.getText().endsWith("[1] 4\n"));
	}
	
	@Test
	public void plotTest() {
		text.typeText("plot(rnorm(100))\n");
		try {Thread.sleep(5000);} catch (InterruptedException e) {}
		boolean viewPresent = false;
		for (SWTBotView views : bot.views()) {
			if (views.getReference().getId().equals("org.eclipse.statet.r.views.RGraphic")) {
				viewPresent = true;
				break;
			}
		}
		bot.viewById("org.eclipse.statet.r.views.RGraphic").close();
		assertTrue(viewPresent);
	}
		
	@Test
	public void helpTest() {
		text.typeText("?lm\n");
		try {Thread.sleep(500);} catch (InterruptedException e) {}
		boolean viewPresent = false;
		for (SWTBotView views : bot.views()) {
			if (views.getReference().getId().equals("org.eclipse.statet.r.views.RHelp")) {
				viewPresent = true;
				break;
			}
		}
		bot.viewById("org.eclipse.statet.r.views.RHelp").close();
		assertTrue(viewPresent);
	}
	
	@Test
	public void rScriptTest() {
		bot.menu("File").menu("Open Projects from File System...").click();
		bot.shell("Import Projects from File System or Archive").activate();
		bot.comboBoxWithLabel("Import source:").setText("/home/bvanbruggen/git/architect/eu.openanalytics.architect.tests/workspace/testProject");
		try {
			bot.button("Finish").click();
		} catch (Exception e) {
			// This may fail if multiple tests run in the same workspace: the project is already imported
			bot.button("Cancel").click();
		}		
		
		SWTBotView projectView = bot.viewByTitle("Project Explorer");
		projectView.show();

		SWTBotTreeItem projectItem = null;
		for (SWTBotTreeItem item : projectView.bot().tree().getAllItems()) {
			if (item.getText().contains(PROJECT_NAME))
				projectItem = item;
		}
		SWTBotTreeItem testFileItem = null;
		for (SWTBotTreeItem item : projectView.bot().tree().expandNode(projectItem.getText()).getItems()) {
			if (item.getText().contains("RScriptTest.R"))
				testFileItem = item;
		}
		testFileItem.doubleClick();
		
		SWTBotEclipseEditor editor = bot.editorByTitle("RScriptTest.R").toTextEditor();
		editor.setFocus();
		
		editor.navigateTo(6, 1);
		editor.pressShortcut(SWT.CTRL, 'r');
		editor.pressShortcut(SWT.CTRL, 'r');
		
		try {Thread.sleep(2000);} catch (InterruptedException e) {}
		assertTrue(text.getText().endsWith("[1] 4\n"));
		editor.close();
	}
	
	@Test
	public void shinyTest() {
		text.typeText("install.packages(\"shiny\", repos = \"https://cloud.r-project.org\")\n");
		try {Thread.sleep(20000);} catch (InterruptedException e) {}
		text.typeText("remove.packages(\"shiny\")\n");
		try {Thread.sleep(20000);} catch (InterruptedException e) {}
	}
}
