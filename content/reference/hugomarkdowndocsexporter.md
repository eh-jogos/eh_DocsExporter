---  
title: HugoMarkdownDocsExporter  
author: eh-jogos  
date: 2020-10-05T07:30:54-03:00  
weight: 1  
---  
**Inherits:** _[MarkdownDocsExporter]({{< ref "/reference/markdowndocsexporter" >}}) > [JsonIO]({{< ref "/reference/jsonio" >}}) > [Reference](https://docs.godotengine.org/en/stable/classes/class_reference.html) > [Object](https://docs.godotengine.org/en/stable/classes/class_object.html)_  
## Description  
 Exports md files configured to work with Hugo. It's supposed to work with any theme, but it was
 only tested with hugo-theme-learn. It's recommended to export the whole reference into a folder
 inside the "content" folder of your hugo site, but not directly in content, without any 
 subfolder.

 In addition to that, if you use @category, a subfolder with it's own _index.md will be created
 for each category. You can order them and add descriptions to this pages in the Docs Exporter tab
 in the Project Settings.
  
## Properties 
  
| type | property | default value |  
| ---- | -------- | ------------- |  
| [String](https://docs.godotengine.org/en/stable/classes/class_string.html) | [author]({{< ref "/reference/hugomarkdowndocsexporter#author" >}}) | `"eh-jogos"` |  
| [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html) | [should_create_toc_on_category_pages]({{< ref "/reference/hugomarkdowndocsexporter#should_create_toc_on_category_pages" >}}) | `Null` |  
  
## Methods 
  
| return type | method signature |  
| ----------- | ---------------- |  
| [null](https://docs.godotengine.org/en/stable/classes/class_null.html) | **[export_hugo_site_pages]({{< ref "/reference/hugomarkdowndocsexporter#export_hugo_site_pages" >}})**([String](https://docs.godotengine.org/en/stable/classes/class_string.html) reference_json_path, [String](https://docs.godotengine.org/en/stable/classes/class_string.html) export_path) |  
  
## Constants  
  
- **HUGO_CHAPTER_FRONT_MATTER = "---  title: {title}  author: {author}  date: {datetime}  weight: {weight}  ---  "** --- Front matter that will be used for category pages. 
- **HUGO_DEFAULT_FRONT_MATTER = "---  title: {title}  author: {author}  date: {datetime}  weight: 1  ---  "** --- Front matter that will be used to default pages. 
  
## Properties Descriptions  
  
### author 
- _[String](https://docs.godotengine.org/en/stable/classes/class_string.html)_ **author**  
  
| | |  
| - |:-:|  
| _Default_ | ` "eh-jogos" ` |  

 Author to be used across the site's front matters.
  
---------
### should_create_toc_on_category_pages 
- _[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html)_ **should_create_toc_on_category_pages**  
  
 Enables / Disables table of contents in category pages.
  
---------
## Method Descriptions  
  
### export_hugo_site_pages 
- _void_ **export_hugo_site_pages**([String](https://docs.godotengine.org/en/stable/classes/class_string.html) reference_json_path, [String](https://docs.godotengine.org/en/stable/classes/class_string.html) export_path) 
  
 Takes in the reference json file path and an export path and generates and exports hugo 
 formatted .md files.
  
---------
