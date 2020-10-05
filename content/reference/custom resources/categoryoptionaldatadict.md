---  
title: CategoryOptionalDataDict  
author: eh-jogos  
date: 2020-10-05T07:30:54-03:00  
weight: 1  
---  
**Inherits:** _[Resource](https://docs.godotengine.org/en/stable/classes/class_resource.html) > [Reference](https://docs.godotengine.org/en/stable/classes/class_reference.html) > [Object](https://docs.godotengine.org/en/stable/classes/class_object.html)_  
## Description  
 Dictionary of [CategoryOptionalData]({{< ref "/reference/custom resources/categoryoptionaldata" >}}), to be saved in disk and used somewhat like a database by the
 plugin. This is what allows it to show the relevant fields in the Docs Exporter tab.

 If you rename a category and the description disappears, look for the file in 
 `res://addons/eh_jogos.docs-exporter/shared_variables/dict_categories_optional_data.tres` and it
 will still hold the description inside a key with the name of the old category.
 
  
## Properties 
  
| type | property | default value |  
| ---- | -------- | ------------- |  
| [Dictionary](https://docs.godotengine.org/en/stable/classes/class_dictionary.html) | [value]({{< ref "/reference/custom resources/categoryoptionaldatadict#value" >}}) | `{}` |  
  
## Signals  
  
- **value_updated**() 
  
 signal emitted whenever the dictionary changes.
  
---------
  
## Properties Descriptions  
  
### value 
- _[Array](https://docs.godotengine.org/en/stable/classes/class_array.html)_ **value**  
  
| | |  
| - |:-:|  
| _Default_ | ` {} ` |  
| _Setter_ | _set_value |  
| _Getter_ | _get_value |  

 Dictionary that only accepts [CategoryOptionalData] as values.
  
---------
