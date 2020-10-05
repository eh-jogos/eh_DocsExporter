---  
title: FilePathLineEdit  
author: eh-jogos  
date: 2020-10-05T07:30:54-03:00  
weight: 1  
---  
**Inherits:** _[HBoxContainer](https://docs.godotengine.org/en/stable/classes/class_hboxcontainer.html) > [BoxContainer](https://docs.godotengine.org/en/stable/classes/class_boxcontainer.html) > [Container](https://docs.godotengine.org/en/stable/classes/class_container.html) > [Control](https://docs.godotengine.org/en/stable/classes/class_control.html) > [CanvasItem](https://docs.godotengine.org/en/stable/classes/class_canvasitem.html) > [Node](https://docs.godotengine.org/en/stable/classes/class_node.html) > [Object](https://docs.godotengine.org/en/stable/classes/class_object.html)_  
## Description  
 Base class for any kind of PathLineEdit field. Receives a [StringVariable]({{< ref "/reference/shared variables/stringvariable" >}}), which will be 
 responsible not only for the persistence of the data as well as sharing it with any part
 of the project that needs it.

 In the addon there are 3 Scenes for different kind of paths that are used in the Docs Exporter
 tab, one for file paths in the file system, one for directories in the project, and another for
 directories in the file system.
 
  
## Properties 
  
| type | property | default value |  
| ---- | -------- | ------------- |  
| [String](https://docs.godotengine.org/en/stable/classes/class_string.html) | [file_dialog_filter]({{< ref "/reference/ui elements/filepathlineedit#file_dialog_filter" >}}) | `""` |  
| [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html) | [is_removable]({{< ref "/reference/ui elements/filepathlineedit#is_removable" >}}) | `False` |  
  
## Methods 
  
| return type | method signature |  
| ----------- | ---------------- |  
| [null](https://docs.godotengine.org/en/stable/classes/class_null.html) | **[set_string_variable]({{< ref "/reference/ui elements/stringvariablelineedit#set_string_variable" >}})**([StringVariable]({{< ref "/reference/shared variables/stringvariable" >}}) resource) |  
  
## Signals  
  
- **remove_string_variable**(string_variable) 
  
  
---------
  
## Properties Descriptions  
  
### file_dialog_filter 
- _[String](https://docs.godotengine.org/en/stable/classes/class_string.html)_ **file_dialog_filter**  
  
| | |  
| - |:-:|  
| _Default_ | ` "" ` |  

 Filters for the File Explorer window.
  
---------
### is_removable 
- _[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html)_ **is_removable**  
  
| | |  
| - |:-:|  
| _Default_ | ` False ` |  
| _Setter_ | _set_is_removable |  

 Option to turn on/off the remove field button.
  
---------
## Method Descriptions  
  
### set_string_variable 
- _void_ **set_string_variable**([StringVariable]({{< ref "/reference/shared variables/stringvariable" >}}) resource) 
  
 Sets the StringVariable this field will be attached to and populates the LineEdit with its value.
  
---------
