---  
title: ReferenceFormatter  
author: eh-jogos  
date: 2020-10-05T07:30:54-03:00  
weight: 1  
---  
**Inherits:** _[JsonIO]({{< ref "/reference/jsonio" >}}) > [Reference](https://docs.godotengine.org/en/stable/classes/class_reference.html) > [Object](https://docs.godotengine.org/en/stable/classes/class_object.html)_  
## Description  
 Sweepes the project and generates the json reference for the codebase. Started this based on 
 ReferenceCollector.gd from GDQuest's docs maker, but customized it to add to the json some more
 information I wanted to use.
  
  
## Methods 
  
| return type | method signature |  
| ----------- | ---------------- |  
| [null](https://docs.godotengine.org/en/stable/classes/class_null.html) | **[export_formatted_reference_json]({{< ref "/reference/referenceformatter#export_formatted_reference_json" >}})**([Array](https://docs.godotengine.org/en/stable/classes/class_array.html) directories, [Array](https://docs.godotengine.org/en/stable/classes/class_array.html) patterns, [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html) is_recursive, [String](https://docs.godotengine.org/en/stable/classes/class_string.html) save_path) |  
  
## Constants  
  
- **METADATA = {category:@category:}** --- Currently recognized metadata that you can use in the comments, while documenting your code.
 `@category:` - will group pages during export, and save them together in a folder with the same
 name as the category. If you want to use subcategories you can treat it as path. For example
 `# @category: CategoryA/SubcategoryB` will generate a folder named "CategoryA" and inside it 
 a folder named "SubcategoryB". Only works in the main description for the file. 
## Method Descriptions  
  
### export_formatted_reference_json 
- _void_ **export_formatted_reference_json**([Array](https://docs.godotengine.org/en/stable/classes/class_array.html) directories, [Array](https://docs.godotengine.org/en/stable/classes/class_array.html) patterns, [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html) is_recursive, [String](https://docs.godotengine.org/en/stable/classes/class_string.html) save_path) 
  
  
---------
