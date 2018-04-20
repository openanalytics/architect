package eu.openanalytics.arichitect.r.tests;

import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;

import org.eclipse.core.runtime.FileLocator;
import org.eclipse.core.runtime.Path;
import org.eclipse.core.runtime.Platform;
import org.eclipse.swtbot.eclipse.finder.SWTWorkbenchBot;
import org.eclipse.swtbot.eclipse.finder.widgets.SWTBotEclipseEditor;
import org.eclipse.swtbot.eclipse.finder.widgets.SWTBotView;
import org.eclipse.swtbot.swt.finder.widgets.SWTBotShell;
import org.eclipse.swtbot.swt.finder.widgets.SWTBotStyledText;
import org.eclipse.swtbot.swt.finder.widgets.SWTBotTreeItem;
import org.junit.BeforeClass;
import org.junit.Test;
import org.osgi.framework.Bundle;

public class ArchitectTest {

	private static String PROJECT_NAME = "testProject";
	private static String PROJECT_PATH = "./workspace/" + PROJECT_NAME;
	private static String TEST_FILE_NAME = "test.txt";

	private static SWTWorkbenchBot bot;
	private static String resolvedWorkspacePath;

	@BeforeClass
	public static void beforeClass() {
		bot = new SWTWorkbenchBot();

		// Bundle testBundle =
		// Platform.getBundle(ArchitectTest.class.getPackage().getName());
		// URL workspaceURL = FileLocator.find(testBundle, new Path(PROJECT_PATH),
		// null);
		// try {
		// resolvedWorkspacePath = new
		// File(FileLocator.toFileURL(workspaceURL).toURI()).getAbsolutePath();
		// } catch (IOException | URISyntaxException e) {
		// fail("Cannot resolve test data: " + PROJECT_PATH);
		// }
	}

	@Test
	public void testArchitect() {
		SWTBotShell wb = bot.activeShell();

		wb.activate();
		try {Thread.sleep(5000);} catch (InterruptedException e) {}
		// TODO wait until console view has a page for R

		System.out.println("--------------------------------------");
		SWTBotView view = bot.viewById("org.eclipse.ui.console.ConsoleView");
		System.out.println(view.bot().styledText());
		SWTBotStyledText text = view.bot().styledText();
		text.typeText("plot(1)\n");
		text.typeText("??c\n"); // the first question mark is ignored
		text.typeText("c?\n");
		try {Thread.sleep(5000);} catch (InterruptedException e) {}
		text.typeText("q()\n");
		System.out.println("--------------------------------------");
		wb.activate();
		bot.menu("Window").menu("Show View").menu("Other...").click();
		bot.shell("Show View").activate();
		bot.text().setText("navigator");
		bot.button("Open").click();
		
		System.out.println(bot.views());
		for (SWTBotView views : bot.views()) {
			System.out.println(views.getTitle());
		}
		
		view = bot.viewByTitle("Project Explorer");
		view.show();
		System.out.println(view.getToolbarButtons());

		SWTBotTreeItem projectItem = null;
		for (SWTBotTreeItem item : view.bot().tree().getAllItems()) {
			if (item.getText().contains(PROJECT_NAME))
				projectItem = item;
		}
		SWTBotTreeItem testFileItem = null;
		for (SWTBotTreeItem item : view.bot().tree().expandNode(projectItem.getText()).getItems()) {
			if (item.getText().contains(TEST_FILE_NAME))
				testFileItem = item;
		}
		testFileItem.doubleClick();
		try {Thread.sleep(3000);} catch (InterruptedException e) {}
		view.getToolbarButtons().get(0).click();
		
		SWTBotEclipseEditor editor = bot.editorByTitle(TEST_FILE_NAME).toTextEditor();
		editor.setFocus();
		System.out.println(editor.getReference().getId());
		editor.close();
		
		System.out.println("--------------------------------------");

		try {Thread.sleep(100000);} catch (InterruptedException e) {}
		assertTrue(true);
	}
}
