---  
title: MarkdownDocsExporter  
author: eh-jogos  
date: 2020-10-05T07:30:54-03:00  
weight: 1  
---  
**Inherits:** _[JsonIO]({{< ref "/reference/jsonio" >}}) > [Reference](https://docs.godotengine.org/en/stable/classes/class_reference.html) > [Object](https://docs.godotengine.org/en/stable/classes/class_object.html)_  
**Inherited by:** _[HugoMarkdownDocsExporter]({{< ref "/reference/hugomarkdowndocsexporter" >}})_  
  
## Description  
 Main markdown exporter. It exports using github flavor markdown. These .md files can be used
 anywhere, but the links and the _Sidebar.md are configured to work best with github wiki 
 format.
  
## Properties 
  
| type | property | default value |  
| ---- | -------- | ------------- |  
| [Dictionary](https://docs.godotengine.org/en/stable/classes/class_dictionary.html) | [links_db]({{< ref "/reference/markdowndocsexporter#links_db" >}}) | `Null` |  
| [Dictionary](https://docs.godotengine.org/en/stable/classes/class_dictionary.html) | [signatures_db]({{< ref "/reference/markdowndocsexporter#signatures_db" >}}) | `Null` |  
| [String](https://docs.godotengine.org/en/stable/classes/class_string.html) | [key_to_use_for_link]({{< ref "/reference/markdowndocsexporter#key_to_use_for_link" >}}) | `Null` |  
  
## Methods 
  
| return type | method signature |  
| ----------- | ---------------- |  
| [Variant](https://docs.godotengine.org/en/stable/classes/class_variant.html) | **[build_category_db]({{< ref "/reference/markdowndocsexporter#build_category_db" >}})**([String](https://docs.godotengine.org/en/stable/classes/class_string.html) reference_json_path, [String](https://docs.godotengine.org/en/stable/classes/class_string.html) export_path) |  
| [null](https://docs.godotengine.org/en/stable/classes/class_null.html) | **[export_github_wiki_pages]({{< ref "/reference/markdowndocsexporter#export_github_wiki_pages" >}})**([String](https://docs.godotengine.org/en/stable/classes/class_string.html) reference_json_path, [String](https://docs.godotengine.org/en/stable/classes/class_string.html) export_path) |  
  
## Constants  
  
- **MD_BLOCK_INHERITANCE = " **Inherits:** _{inheritance}_  "** --- Defines the "inheritance" block content model and styling for the exported .md file. 
- **MD_BLOCK_INHERITED_BY = " **Inherited by:** _{inherited_by}_  "** --- Defines the "inherited by" block content model and styling for the exported .md file. 
- **MD_BLOCK_DESCRIPTION = "## Description  {description}  "** --- Defines the "Description" block content model and styling for the exported .md file. 
- **MD_BLOCK_PROPERTIES_TABLE_TITLE = "## Properties   | type | property | default value |  | ---- | -------- | ------------- |  "** --- Defines the "Properties" table header content model and styling for the exported .md file. 
- **MD_BLOCK_PROPERTIES_TABLE_LINE = "| {type} | {name} | {default_value} |  "** --- Defines the property table lines content model and styling for the exported .md file. 
- **MD_BLOCK_METHODS_TABLE_TITLE = "## Methods   | return type | method signature |  | ----------- | ---------------- |  "** --- Defines the "Methods" table header content model and styling for the exported .md file. 
- **MD_BLOCK_METHOD_TABLE_LINE = "| {type} | {siganture} |  "** --- Defines the method table lines content model and styling for the exported .md file. 
- **MD_BLOCK_SIGNALS_TITLE = "## Signals    "** --- Defines the "Signals" header content model and styling for the exported .md file. 
- **MD_BLOCK_SIGNALS_LINE = "- **{name}**({arguments})   {description}  --------- "** --- Defines the individial signal content model and styling for the exported .md file. 
- **MD_BLOCK_ENUMS_TITLE = "## Enumerations    "** --- Defines the "Enumerations" header content model and styling for the exported .md file. 
- **MD_BLOCK_ENUM_NAME_LINE = "enum **{name}**:   "** --- Defines the individial enum name content model and styling for the exported .md file. 
- **MD_BLOCK_ENUM_KEY_LINE = "- **{signature}**  "** --- Defines the individial enum keys content model and styling for the exported .md file. 
- **MD_BLOCK_CONSTANTS_TITLE = "## Constants    "** --- Defines the "Constants" header content model and styling for the exported .md file. 
- **MD_BLOCK_CONSTANTS_LINE = "- **{signature}** --- {description} \n"** --- Defines the individial constant content model and styling for the exported .md file. 
- **MD_BLOCK_PROPERTY = "### {name} - {property_signature}    {table}  {description}  ---------** --- Defines the individial property definition content model and styling for the exported .md file. 
- **MD_BLOCK_PROPERTIES_DESCRIPTION = "## Properties Descriptions    "** --- Defines the "Properties Descriptions" header content model and styling for the exported .md file. 
- **MD_BLOCK_METHOD = "### {name} - {method_signature}   {description}  ---------"** --- Defines the individial method definition content model and styling for the exported .md file. 
- **MD_BLOCK_METHOD_DESCRIPTION = "## Method Descriptions    "** --- Defines the "Method Descriptions" header content model and styling for the exported .md file. 
- **GODOT_DOCS_BASE_URL = "https://docs.godotengine.org/en/stable/classes/class_%s.html"** --- Godot's Documentatiion base url for forming links. 
  
## Properties Descriptions  
  
### links_db 
- _[Dictionary](https://docs.godotengine.org/en/stable/classes/class_dictionary.html)_ **links_db**  
  
 Dictionary that serves as database for links and is built during the json export process
  
---------
### signatures_db 
- _[Dictionary](https://docs.godotengine.org/en/stable/classes/class_dictionary.html)_ **signatures_db**  
  
 Dictionary that serves as database for properties and methods signatures and is built during 
 the json export process
  
---------
### key_to_use_for_link 
- _[String](https://docs.godotengine.org/en/stable/classes/class_string.html)_ **key_to_use_for_link**  
  
 If which key from the links database the exporter should use. Github exporter will use 
 "local_path" which just consists of repeating the file name, without extesnion. 
 Hugo exporter will use "full_path" which will take folder structure into account.
  
---------
## Method Descriptions  
  
### build_category_db 
- _[Variant](https://docs.godotengine.org/en/stable/classes/class_variant.html)_ **build_category_db**([String](https://docs.godotengine.org/en/stable/classes/class_string.html) reference_json_path, [String](https://docs.godotengine.org/en/stable/classes/class_string.html) export_path) 
  
 Reads json reference and creates a category database with the current user defined categories 
 in use.
  
---------
### export_github_wiki_pages 
- _void_ **export_github_wiki_pages**([String](https://docs.godotengine.org/en/stable/classes/class_string.html) reference_json_path, [String](https://docs.godotengine.org/en/stable/classes/class_string.html) export_path) 
  
 Takes in the reference json file path and an export path and generates and exports github wiki 
 formatted .md files.
  
---------
