package eu.openanalytics.arichitect.r.tests;

import static org.junit.Assert.assertTrue;

import javax.swing.text.Position;

import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swtbot.eclipse.finder.SWTWorkbenchBot;
import org.eclipse.swtbot.eclipse.finder.widgets.SWTBotEclipseEditor;
import org.eclipse.swtbot.eclipse.finder.widgets.SWTBotEditor;
import org.eclipse.swtbot.eclipse.finder.widgets.SWTBotView;
import org.eclipse.swtbot.swt.finder.widgets.SWTBotShell;
import org.eclipse.swtbot.swt.finder.widgets.SWTBotStyledText;
import org.eclipse.swtbot.swt.finder.widgets.SWTBotTreeItem;
import org.junit.BeforeClass;
import org.junit.Test;


public class ArchitectTest {

	private static String PROJECT_NAME = "testProject";
	private static String WORKSPACE_PATH = "./workspace";
	private static String TEST_FILE_NAME = "test.txt";

	private static SWTWorkbenchBot bot;
	private static String resolvedWorkspacePath;

	@BeforeClass
	public static void beforeClass() {
		bot = new SWTWorkbenchBot();

//		Bundle testBundle = Platform.getBundle(ArchitectTest.class.getPackage().getName());
//		URL workspaceURL = FileLocator.find(testBundle, new Path(WORKSPACE_PATH), null);
//		try {
//			resolvedWorkspacePath = new File(FileLocator.toFileURL(workspaceURL).toURI()).getAbsolutePath();
//		} catch (IOException | URISyntaxException e) {
////			fail("Cannot resolve test data: " + PROJECT_PATH);
//		}
//		
//		SWTBotShell wb = bot.activeShell();
//		wb.activate();
//		bot.menu("File").menu("Open Projects from File System...").click();
//		bot.shell("Import Projects from File System or Archive").activate();
//		bot.comboBoxWithLabel("Import source:").setText(resolvedWorkspacePath);
//		try {
//			bot.button("Finish").click();
//		} catch (Exception e) {
//			// This may fail if multiple tests run in the same workspace: the project is already imported
//			bot.button("Cancel").click();
//		}
	}

	@Test
	public void testArchitect() {
		System.out.println("----------------start tests----------------------");
		SWTBotShell wb = bot.activeShell();
		wb.activate();
		try {Thread.sleep(10000);} catch (InterruptedException e) {}
		// TODO wait until console view has a page for R
		SWTBotView view = bot.viewById("org.eclipse.ui.console.ConsoleView");
		SWTBotStyledText text = view.bot().styledText();
		
		text.typeText("a5");
		text = view.bot().styledText("a5");
		text.navigateTo(text.cursorPosition().line, text.cursorPosition().column - 1);
		text.pressShortcut(SWT.CTRL, '=');
		System.out.println(text.getText());
		System.out.println("----------------pause----------------------");
		try {Thread.sleep(100000);} catch (InterruptedException e) {}
		
//		text.typeText("2+2\n");
//		try {Thread.sleep(2000);} catch (InterruptedException e) {}
//		assertTrue(text.getText().endsWith("[1] 4\n"));
//		
//		text.typeText("plot(rnorm(100))\n");
//		try {Thread.sleep(500);} catch (InterruptedException e) {}
//		boolean viewPresent = false;
//		for (SWTBotView views : bot.views()) {
//			if (views.getReference().getId().equals("org.eclipse.statet.r.views.RGraphic")) {
//				viewPresent = true;
//				break;
//			}
//		}
//		bot.viewById("org.eclipse.statet.r.views.RGraphic").close();
//		assertTrue(viewPresent);
//		
//		text.typeText("??lm\n");
//		SWTBotView helpView = bot.viewById("org.eclipse.statet.r.views.RHelp");
//		try {Thread.sleep(500);} catch (InterruptedException e) {}
//		viewPresent = false;
//		for (SWTBotView views : bot.views()) {
//			if (views.getReference().getId().equals("org.eclipse.statet.r.views.RHelp")) {
//				viewPresent = true;
//				break;
//			}
//		}
//		bot.viewById("org.eclipse.statet.r.views.RHelp").close();
//		assertTrue(viewPresent);
//		
//		try {Thread.sleep(100000);} catch (InterruptedException e) {}
//		view.getToolbarButtons().get(2).click();
//		System.out.println("----------------Preferences Test----------------------");
//		bot.menu("Window").menu("Preferences").click();
//		bot.shell("Preferences").activate();
//		SWTBotShell preferences = bot.activeShell();
//		preferences.display.getData();
		System.out.println("------------------autocomplete start--------------------");
		text.typeText("med");
		try {Thread.sleep(5000);} catch (InterruptedException e) {}
		text = view.bot().styledText("med");
		text.pressShortcut(SWT.CTRL, ' ');
		try {Thread.sleep(5000);} catch (InterruptedException e) {}
//		SWTBotShell autocompletShell = bot.activeShell();
//		autocompletShell.activate();
//		System.out.println(autocompletShell.getText());
//		try {Thread.sleep(100000);} catch (InterruptedException e) {}
		for (SWTBotShell shell : bot.shells()) {
			Shell shellWidget = shell.widget;
			if (shell.getText().equals("")) {
				System.out.println(shellWidget.getText());
			}
			shellWidget.getChildren();
//			System.out.println(shellWidget.getText());
//			System.out.println(shellWidget.getChildren().toString());
			
			System.out.println("id: " + shell.getId() + " text: " + shell.getText() + " string: " + shell.toString());
		}
		SWTBotShell autoCompletShell = bot.shell("Quick Access");
		autoCompletShell.close();
		try {Thread.sleep(5000);} catch (InterruptedException e) {}
		text.typeText("med");
//		SWTBotShell autoComplete = bot.activeShell();
//		System.out.println(autoComplete.toString());
		System.out.println("----------------Object Browser Test----------------------");
		try {Thread.sleep(2000);} catch (InterruptedException e) {}
		text.typeText("example(glm)\n");
		
		bot.menu("Window").menu("Show View").menu("Other...").click();
		bot.shell("Show View").activate();
		bot.text().setText("Object Browser");
		bot.button("Open").click();
		
		SWTBotView obView = bot.viewByTitle("Object Browser");
		
		SWTBotTreeItem globalEnv = null;
		for (SWTBotTreeItem item : obView.bot().tree().getAllItems()) {
			if (item.getText().contains(".GlobalEnv")) globalEnv = item;
		}
		globalEnv.expand();
		
		SWTBotTreeItem glmFolder = null;
		for (SWTBotTreeItem item : globalEnv.getItems()) {
			if (item.getText().contains("glm.D93")) glmFolder = item;
		}
		glmFolder.expand();
		System.out.println("----------------" + glmFolder.getText() + "----------------------");
		
 		SWTBotTreeItem qrFolder = null;
		for (SWTBotTreeItem item : glmFolder.getItems()) {
			if (item.getText().contains("qr")) {
				qrFolder = item;
			}
		}
		qrFolder.expand();
		System.out.println("----------------" + qrFolder.getText() + "----------------------");

		SWTBotTreeItem qrFile = null;
		for (SWTBotTreeItem item : qrFolder.getItems()) {
			if (item.getText().contains("qr ")) qrFile = item;
		}
		System.out.println("----------------" + qrFile.getText() + "----------------------");
		
		qrFile.contextMenu("Open in Data Viewer").click();
		
		SWTBotEditor glm = bot.editorByTitle("glm.D93$qr$qr");
		glm.setFocus();
		Composite widget = (Composite) glm.getWidget();
		widget.getChildren();
		System.out.println(glm.toString());
//		glm.getReference().
		glm.close();
		try {Thread.sleep(100000);} catch (InterruptedException e) {}
		System.out.println("----------------RScript Fresh Install start----------------------");
		try {Thread.sleep(10000);} catch (InterruptedException e) {}
		System.out.println(text.getText());
		try {Thread.sleep(1000000);} catch (InterruptedException e) {}
		bot.menu("File").menu("Open Projects from File System...").click();
		bot.shell("Import Projects from File System or Archive").activate();
		bot.comboBoxWithLabel("Import source:").setText("/home/bvanbruggen/git/architect/eu.openanalytics.architect.tests/workspace/testProject");
		try {
			bot.button("Finish").click();
		} catch (Exception e) {
			// This may fail if multiple tests run in the same workspace: the project is already imported
			bot.button("Cancel").click();
		}		
		
		view = bot.viewByTitle("Project Explorer");
		view.show();

		SWTBotTreeItem projectItem = null;
		for (SWTBotTreeItem item : view.bot().tree().getAllItems()) {
			if (item.getText().contains(PROJECT_NAME))
				projectItem = item;
		}
		SWTBotTreeItem testFileItem = null;
		for (SWTBotTreeItem item : view.bot().tree().expandNode(projectItem.getText()).getItems()) {
			if (item.getText().contains("RScriptTest.R"))
				testFileItem = item;
		}
		testFileItem.doubleClick();
		
		SWTBotEclipseEditor editor = bot.editorByTitle("RScriptTest.R").toTextEditor();
		editor.setFocus();
		
		editor.navigateTo(6, 1);
		editor.pressShortcut(SWT.CTRL, 'r');
		editor.pressShortcut(SWT.CTRL, 'r');
		try {Thread.sleep(100000);} catch (InterruptedException e) {}
		System.out.println("----------------RScript start----------------------");
		view = bot.viewByTitle("Project Explorer");
		view.show();
		System.out.println(view.getToolbarButtons());

//		SWTBotTreeItem projectItem = null;
//		for (SWTBotTreeItem item : view.bot().tree().getAllItems()) {
//			if (item.getText().contains(PROJECT_NAME))
//				projectItem = item;
//		}
//		SWTBotTreeItem testFileItem = null;
//		for (SWTBotTreeItem item : view.bot().tree().expandNode(projectItem.getText()).getItems()) {
//			if (item.getText().contains("random.R"))
//				testFileItem = item;
//		}
//		testFileItem.doubleClick();
//		
//		SWTBotEclipseEditor editor = bot.editorByTitle("random.R").toTextEditor();
//		editor.setFocus();
//		
//		editor.navigateTo(6, 1);
//		editor.pressShortcut(SWT.CTRL, 'r');
//		editor.pressShortcut(SWT.CTRL, 'r');
		System.out.println("----------------PackageManager start----------------------");
//		view.bot().buttonWithTooltip("View Menu").click();
//		for (SWTBotToolbarButton button : view.getToolbarButtons()) {
//			System.out.println("id: " + button.getId() + " text: " + button.getText() + " toolTipText: " + button.getToolTipText());
//		}
		try {Thread.sleep(300000);} catch (InterruptedException e) {}
		System.out.println("----------------installPackages start----------------------");
//		System.out.println(view.bot().styledText());
//		try {Thread.sleep(100000);} catch (InterruptedException e) {}
		for (SWTBotShell shell : bot.shells()) {
			System.out.println("id: " + shell.getId() + " text: " + shell.getText() + " string: " + shell.toString());
		}
		text.typeText("install.packages(\"RApiDatetime\")\n");
		try {Thread.sleep(10000);} catch (InterruptedException e) {}
		for (SWTBotShell shell : bot.shells()) {
			System.out.println("id: " + shell.getId() + " text: " + shell.getText() + " string: " + shell.toString());
		}
//		text.typeText("chooseCRANmirror(graphics = FALSE)\n");
//		try {Thread.sleep(1000);} catch (InterruptedException e) {}
//		text.typeText("8\n");
		
//		try {Thread.sleep(10000);} catch (InterruptedException e) {}
//		text.typeText("install.packages(\"gtable\", repos = \"https://cloud.r-project.org\")\n");
		System.out.println("----------------installPackages end----------------------");
//		System.out.println(text.getText());
		try {Thread.sleep(300000);} catch (InterruptedException e) {}
		
		System.out.println("--------------------------------------");
		wb.activate();
		
		System.out.println(bot.views());
		for (SWTBotView views : bot.views()) {
			System.out.println(views.getTitle());
		}
		
		view = bot.viewByTitle("Project Explorer");
		view.show();
		System.out.println(view.getToolbarButtons());

		projectItem = null;
		for (SWTBotTreeItem item : view.bot().tree().getAllItems()) {
			if (item.getText().contains(PROJECT_NAME))
				projectItem = item;
		}
		testFileItem = null;
		for (SWTBotTreeItem item : view.bot().tree().expandNode(projectItem.getText()).getItems()) {
			if (item.getText().contains(TEST_FILE_NAME))
				testFileItem = item;
		}
		testFileItem.doubleClick();
		try {Thread.sleep(3000);} catch (InterruptedException e) {}
		view.getToolbarButtons().get(0).click();
		
		editor = bot.editorByTitle(TEST_FILE_NAME).toTextEditor();
		editor.setFocus();
		System.out.println(editor.getReference().getId());
		editor.close();
		
		view.show();
		projectItem = null;
		for (SWTBotTreeItem item : view.bot().tree().getAllItems()) {
			if (item.getText().contains(PROJECT_NAME))
				projectItem = item;
		}
		testFileItem = null;
		for (SWTBotTreeItem item : view.bot().tree().expandNode(projectItem.getText()).getItems()) {
			if (item.getText().contains("A3.R"))
				testFileItem = item;
		}
		testFileItem.doubleClick();
		try {Thread.sleep(3000);} catch (InterruptedException e) {}
		
		editor = bot.editorByTitle("A3.R").toTextEditor();
		editor.setFocus();
		System.out.println(editor.getReference().getId());
		editor.close();
		
		System.out.println("--------------------------------------");

		try {Thread.sleep(10000);} catch (InterruptedException e) {}
		assertTrue(true);
	}
}
