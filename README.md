<img src="https://raw.githubusercontent.com/eh-jogos/eh_DocsExporter/master/addons/eh_jogos.docs-exporter/docs_exporter_icon.png" width="150px" alt="eh_DocsExporter logo">

# eh_DocsExporter

Godot Plugin to export documentation directly from comments in your code to Github Wikis and/or Hugo sites.

It's partly based on GDQuest's docs maker, but works entirely inside Godot, and tries to follow godot's official docs styling for exported pages.

To use, install and activate the plugin and a new tab will appear in the Project Settings window. From there you can configure paths and generate the json with the code reference, and then export it for Github wiki and/or Hugo sites.

To create documentation, just add comments on the line directly above anything you want to add a "description" to. (function definitions, variables, signals, class_name etc...)

You can also organize your exported pages in "categories" by adding "@category: your_category_name" or "@category: your_category_name/your_subcategory_name" in the comments description for the file's class_name. 

## License
This is Licensed under MIT as you and see in the LICENSE file, so use it however you want, in any comercial projects or not, just link this repository or this readme in the credits or somewhere.
