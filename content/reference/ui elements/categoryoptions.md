---  
title: CategoryOptions  
author: eh-jogos  
date: 2020-10-05T07:30:54-03:00  
weight: 1  
---  
**Inherits:** _[VBoxContainer](https://docs.godotengine.org/en/stable/classes/class_vboxcontainer.html) > [BoxContainer](https://docs.godotengine.org/en/stable/classes/class_boxcontainer.html) > [Container](https://docs.godotengine.org/en/stable/classes/class_container.html) > [Control](https://docs.godotengine.org/en/stable/classes/class_control.html) > [CanvasItem](https://docs.godotengine.org/en/stable/classes/class_canvasitem.html) > [Node](https://docs.godotengine.org/en/stable/classes/class_node.html) > [Object](https://docs.godotengine.org/en/stable/classes/class_object.html)_  
## Description  
 UI Element for the category optional data used by the Docs Exporter tab. 
 It's through these that the user of the addon will be
 able to customize the weight and description of the Hugo export for each category they create.
 
 This element will be populated by a [CategoryOptionalData]({{< ref "/reference/custom resources/categoryoptionaldata" >}}) resource which will handle the
 persistence and the sharing of this data with any part of the code that needs it. Anything filled
 in the Docs Exporter tab will be saved in the file 
 `res://addons/eh_jogos.docs-exporter/shared_variables/dict_categories_optional_data.tres`
 
  
  
## Methods 
  
| return type | method signature |  
| ----------- | ---------------- |  
| [null](https://docs.godotengine.org/en/stable/classes/class_null.html) | **[populate_category_entry]({{< ref "/reference/ui elements/categoryoptions#populate_category_entry" >}})**([String](https://docs.godotengine.org/en/stable/classes/class_string.html) p_name, [CategoryOptionalData]({{< ref "/reference/custom resources/categoryoptionaldata" >}}) p_data) |  
## Method Descriptions  
  
### populate_category_entry 
- _void_ **populate_category_entry**([String](https://docs.godotengine.org/en/stable/classes/class_string.html) p_name, [CategoryOptionalData]({{< ref "/reference/custom resources/categoryoptionaldata" >}}) p_data) 
  
 Sets the [CategoryOptionalData] this element will be attached to and fill its fields with 
 their value.
  
---------
