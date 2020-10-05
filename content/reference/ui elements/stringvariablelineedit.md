---  
title: StringVariableLineEdit  
author: eh-jogos  
date: 2020-10-05T07:30:54-03:00  
weight: 1  
---  
**Inherits:** _[LineEdit](https://docs.godotengine.org/en/stable/classes/class_lineedit.html) > [Control](https://docs.godotengine.org/en/stable/classes/class_control.html) > [CanvasItem](https://docs.godotengine.org/en/stable/classes/class_canvasitem.html) > [Node](https://docs.godotengine.org/en/stable/classes/class_node.html) > [Object](https://docs.godotengine.org/en/stable/classes/class_object.html)_  
## Description  
 LineEdit Field for simple [StringVariable]({{< ref "/reference/shared variables/stringvariable" >}})s.
 
  
## Properties 
  
| type | property | default value |  
| ---- | -------- | ------------- |  
| [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html) | [is_removable]({{< ref "/reference/ui elements/stringvariablelineedit#is_removable" >}}) | `False` |  
  
## Methods 
  
| return type | method signature |  
| ----------- | ---------------- |  
| [null](https://docs.godotengine.org/en/stable/classes/class_null.html) | **[set_string_variable]({{< ref "/reference/ui elements/stringvariablelineedit#set_string_variable" >}})**([StringVariable]({{< ref "/reference/shared variables/stringvariable" >}}) resource) |  
  
## Signals  
  
- **remove_string_variable**(string_variable) 
  
  
---------
  
## Properties Descriptions  
  
### is_removable 
- _[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html)_ **is_removable**  
  
| | |  
| - |:-:|  
| _Default_ | ` False ` |  
| _Setter_ | _set_is_removable |  

  
---------
## Method Descriptions  
  
### set_string_variable 
- _void_ **set_string_variable**([StringVariable]({{< ref "/reference/shared variables/stringvariable" >}}) resource) 
  
 Sets the StringVariable this field will be attached to and populates the LineEdit with its value.
  
---------
