---  
title: DictionaryVariable  
author: eh-jogos  
date: 2020-10-05T07:30:54-03:00  
weight: 1  
---  
**Inherits:** _[Resource](https://docs.godotengine.org/en/stable/classes/class_resource.html) > [Reference](https://docs.godotengine.org/en/stable/classes/class_reference.html) > [Object](https://docs.godotengine.org/en/stable/classes/class_object.html)_  
## Description  
 Dictionary that can be saved in disk like a custom resource. 
 Used as [Shared Variables] so that the data it holds can be accessed and modified from multiple 
 parts of the code. Based on the idea of Unity's Scriptable Objects and Ryan Hipple's Unite Talk.
 
  
## Properties 
  
| type | property | default value |  
| ---- | -------- | ------------- |  
| [Dictionary](https://docs.godotengine.org/en/stable/classes/class_dictionary.html) | [value]({{< ref "/reference/shared variables/dictionaryvariable#value" >}}) | `{}` |  
  
## Signals  
  
- **value_updated**() 
  
 Signal emitted when the Variable's value is updated.
  
---------
  
## Properties Descriptions  
  
### value 
- _[Array](https://docs.godotengine.org/en/stable/classes/class_array.html)_ **value**  
  
| | |  
| - |:-:|  
| _Default_ | ` {} ` |  
| _Setter_ | _set_value |  

 Shared Variable value
  
---------
