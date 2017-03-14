Updater approach:
----------------

There are three workspace folders, each with a different update mode:

workspace.initial

	These files are only copied the first time Architect runs on a workspace (empty or pre-existing workspace).
	Later on, they are not modified anymore: they are under the user's control.

workspace.controlled.versioned

	These files are overwritten whenever the version in ws.version.info is higher than the user's workspace version.
	This corresponds to the old workspace updater method.
	
workspace.controlled.auto

	These files are overwritten every time Architect starts up.
	Any changes a user makes will be lost on the next startup.
	
Note: in each of these 3 folders, you can place either default and/or platform-specific subfolders.