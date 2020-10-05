---  
title: StringVariableArray  
author: eh-jogos  
date: 2020-10-05T07:30:54-03:00  
weight: 1  
---  
**Inherits:** _[Resource](https://docs.godotengine.org/en/stable/classes/class_resource.html) > [Reference](https://docs.godotengine.org/en/stable/classes/class_reference.html) > [Object](https://docs.godotengine.org/en/stable/classes/class_object.html)_  
## Description  
 Array of [StringVariable]({{< ref "/reference/shared variables/stringvariable" >}}) that can be saved in disk like a custom resource. 
 Used as [Shared Variables] so that the data it holds can be accessed and modified from multiple 
 parts of the code. Based on the idea of Unity's Scriptable Objects and Ryan Hipple's Unite Talk.
 
  
## Properties 
  
| type | property | default value |  
| ---- | -------- | ------------- |  
| [Array](https://docs.godotengine.org/en/stable/classes/class_array.html) | [value]({{< ref "/reference/shared variables/stringvariablearray#value" >}}) | `[]` |  
  
## Methods 
  
| return type | method signature |  
| ----------- | ---------------- |  
| [null](https://docs.godotengine.org/en/stable/classes/class_null.html) | **[push]({{< ref "/reference/shared variables/stringvariablearray#push" >}})**([Variant](https://docs.godotengine.org/en/stable/classes/class_variant.html) element) |  
| [null](https://docs.godotengine.org/en/stable/classes/class_null.html) | **[erase]({{< ref "/reference/shared variables/stringvariablearray#erase" >}})**([StringVariable]({{< ref "/reference/shared variables/stringvariable" >}}) element) |  
| [Array](https://docs.godotengine.org/en/stable/classes/class_array.html) | **[get_string_array]({{< ref "/reference/shared variables/stringvariablearray#get_string_array" >}})**() |  
  
## Signals  
  
- **value_updated**() 
  
 Signal emitted when the Variable's value is updated.
  
---------
  
## Properties Descriptions  
  
### value 
- _[Array](https://docs.godotengine.org/en/stable/classes/class_array.html)_ **value**  
  
| | |  
| - |:-:|  
| _Default_ | ` [] ` |  
| _Setter_ | _set_value |  
| _Getter_ | _get_value |  

 Shared Variable value
  
---------
## Method Descriptions  
  
### push 
- _void_ **push**([Variant](https://docs.godotengine.org/en/stable/classes/class_variant.html) element) 
  
  
---------
### erase 
- _void_ **erase**([StringVariable]({{< ref "/reference/shared variables/stringvariable" >}}) element) 
  
  
---------
### get_string_array 
- _[Array](https://docs.godotengine.org/en/stable/classes/class_array.html)_ **get_string_array**() 
  
  
---------
