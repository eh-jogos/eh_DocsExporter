---  
title: CategoryOptionalData  
author: eh-jogos  
date: 2020-10-05T07:30:54-03:00  
weight: 1  
---  
**Inherits:** _[Resource](https://docs.godotengine.org/en/stable/classes/class_resource.html) > [Reference](https://docs.godotengine.org/en/stable/classes/class_reference.html) > [Object](https://docs.godotengine.org/en/stable/classes/class_object.html)_  
## Description  
 Struct to hold optional data for categories, like descriptions or weight to be used in HUGO
 
  
## Properties 
  
| type | property | default value |  
| ---- | -------- | ------------- |  
| [int](https://docs.godotengine.org/en/stable/classes/class_int.html) | [weight]({{< ref "/reference/custom resources/categoryoptionaldata#weight" >}}) | `0` |  
| [String](https://docs.godotengine.org/en/stable/classes/class_string.html) | [description]({{< ref "/reference/custom resources/categoryoptionaldata#description" >}}) | `""` |  
  
## Signals  
  
- **struct_updated**() 
  
 Signal emitted whenever any struct variable is changed.
  
---------
  
## Properties Descriptions  
  
### weight 
- _[int](https://docs.godotengine.org/en/stable/classes/class_int.html)_ **weight**  
  
| | |  
| - |:-:|  
| _Default_ | ` 0 ` |  
| _Setter_ | _set_weight |  

 Value hugo will use to order categories in the side menu. "Heavier" categories will appear to 
 the bottom and "lighter" ones will appear towards the top. Be careful though that "0" means 
 "disabled" so if you start setting weights for some categories set the ones you want to be on top
 with at least a value of "1"

 Can be filled in through the Docs exporter tab, in the Project Settings.
  
---------
### description 
- _[String](https://docs.godotengine.org/en/stable/classes/class_string.html)_ **description**  
  
| | |  
| - |:-:|  
| _Default_ | ` "" ` |  
| _Setter_ | _set_description |  

 Each category page gets a TOC with all the links that are inside it. If you want this auto 
 generated page to have a description as well, use this field. 

 Can be filled in through the Docs exporter tab, in the Project Settings.
  
---------
