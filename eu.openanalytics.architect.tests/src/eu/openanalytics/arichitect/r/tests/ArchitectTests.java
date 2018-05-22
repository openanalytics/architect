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

	@BeforeClass
	public static void beforeClass() {
		bot = new SWTWorkbenchBot();
	}

	@Test
	public void testArchitect() {
		System.out.println("----------------start tests----------------------");
		SWTBotShell wb = bot.activeShell();
		wb.activate();
		try {Thread.sleep(5000);} catch (InterruptedException e) {}
		// TODO wait until console view has a page for R
		SWTBotView view = bot.viewById("org.eclipse.ui.console.ConsoleView");
		SWTBotStyledText text = view.bot().styledText();
		
		text.typeText("2+2\n");
		try {Thread.sleep(2000);} catch (InterruptedException e) {}
		assertTrue(text.getText().endsWith("[1] 4\n"));
		
		text.typeText("plot(rnorm(100))\n");
		try {Thread.sleep(500);} catch (InterruptedException e) {}
		boolean viewPresent = false;
		for (SWTBotView views : bot.views()) {
			if (views.getReference().getId().equals("org.eclipse.statet.r.views.RGraphic")) {
				viewPresent = true;
				break;
			}
		}
		bot.viewById("org.eclipse.statet.r.views.RGraphic").close();
		assertTrue(viewPresent);
		
		text.typeText("??lm\n");
		SWTBotView helpView = bot.viewById("org.eclipse.statet.r.views.RHelp");
		try {Thread.sleep(500);} catch (InterruptedException e) {}
		viewPresent = false;
		for (SWTBotView views : bot.views()) {
			if (views.getReference().getId().equals("org.eclipse.statet.r.views.RHelp")) {
				viewPresent = true;
				break;
			}
		}
		bot.viewById("org.eclipse.statet.r.views.RHelp").close();
		assertTrue(viewPresent);
		
		try {Thread.sleep(100000);} catch (InterruptedException e) {}
		view.getToolbarButtons().get(2).click();
	}
}
