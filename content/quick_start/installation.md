---
title: "Installation"
author: eh-jogos  
date: 2020-10-07T06:36:52-03:00
weight: 1
---

There are some different ways of installing the plugin. The easiest one is downloading it from Godot's Asset Library directly from your project. 

![Image of Godot with Asset Library Button highlighted](images/assetlib_button.png)  

Click the Asset Library button inside the editor and in the search field begin typing eh_DocsExporter to find it.

![Image of a search done in the Asset Library with eh_DocsExporter as a result](images/assetlib_docs_exporter_search.png)

After clicking on it, click on the download button and a bar with the downloading plugin will appear at the bottom of the AssetLib

![Image of Plugin popup page](images/assetlib_docs_exporter_popup.png)
![Image of downloaded plugins possibly side by side](images/assetlib_docs_exporter_downloaded.png)

After it finishes downloading click install. It will bring up a list of files it will import.
You don't need to import the files outside of the "addons" folder, your project should already have it's own and README and LICENSE files.

![Image of File Importing window](images/assetlib_importing_files_window.png)

Also if you downloaded any other plugin by me chances are you already have a eh_jogos.shared_variables folder (at the bottom of the list). These are scripts for Custom Resources I reuse in projects and you can ignore any conflicts in this folder, and just import the files that are new to this plugin, if there are any. Or if you're in doubt you can safely overwrite all the files in it by importing them again

![Image of File Importing window showing shared variables folder](images/assetlib_importing_shared_variables_definition.png)

After installation go to Project > Project Settings > Plugin and enable the plugin

![Image of Plugins tab](images/project_settings_plugins_tab.png)  

After you enable it, a new tab will appear named Docs Exporter and that's it for installation!

![Image of Docs Exporter Tab](images/project_settings_docs_exporter_tab_empty.png)

Alternatively, you can just download this repository as a zip, and extract it and copy the addons folder into your project, or clone this repository into your project as a sub-module.

After either, go to Project > Project Settings > Plugin and enable the plugin

