---  
title: Collapsible  
author: eh-jogos  
date: 2020-10-05T07:30:54-03:00  
weight: 1  
---  
**Inherits:** _[Node](https://docs.godotengine.org/en/stable/classes/class_node.html) > [Object](https://docs.godotengine.org/en/stable/classes/class_object.html)_  
## Description  
 Component with collapsible behavior to easily be attached to any UI needs.
 It takes two variables, the NodePath for a text element which will be handled to give feedback 
 for collapsible options or state, and a NodePath for the node that must be toggled when 
 collapsed. 

 If attached directly to a Button of any kind, it will auto connect with the "pressed" signal.
 If this behavior is not desirable, just uncheck the option `should_auto_connect`
 
  
## Properties 
  
| type | property | default value |  
| ---- | -------- | ------------- |  
| [NodePath](https://docs.godotengine.org/en/stable/classes/class_nodepath.html) | [text_element_path]({{< ref "/reference/components/collapsible#text_element_path" >}}) | `""` |  
| [NodePath](https://docs.godotengine.org/en/stable/classes/class_nodepath.html) | [collapsible_node_path]({{< ref "/reference/components/collapsible#collapsible_node_path" >}}) | `""` |  
| [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html) | [should_auto_connect]({{< ref "/reference/components/collapsible#should_auto_connect" >}}) | `True` |  
  
## Methods 
  
| return type | method signature |  
| ----------- | ---------------- |  
| [null](https://docs.godotengine.org/en/stable/classes/class_null.html) | **[toggle_collapse]({{< ref "/reference/components/collapsible#toggle_collapse" >}})**() |  
| [null](https://docs.godotengine.org/en/stable/classes/class_null.html) | **[handle_text]({{< ref "/reference/components/collapsible#handle_text" >}})**() |  
  
## Properties Descriptions  
  
### text_element_path 
- _[NodePath](https://docs.godotengine.org/en/stable/classes/class_nodepath.html)_ **text_element_path**  
  
| | |  
| - |:-:|  
| _Default_ | ` "" ` |  

 NodePath for the feedback text.
  
---------
### collapsible_node_path 
- _[NodePath](https://docs.godotengine.org/en/stable/classes/class_nodepath.html)_ **collapsible_node_path**  
  
| | |  
| - |:-:|  
| _Default_ | ` "" ` |  

 NodePath for the node that must be toggled on/off when collapsed.
  
---------
### should_auto_connect 
- _[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html)_ **should_auto_connect**  
  
| | |  
| - |:-:|  
| _Default_ | ` True ` |  

 Turn this off if you don't want the component to try to auto connect with the pressed signal
 of the parent, in case the parent is a Button.
  
---------
## Method Descriptions  
  
### toggle_collapse 
- _void_ **toggle_collapse**() 
  
 Will collapse/expand the target node, and also trigger a change in the text as additional
 feedback
  
---------
### handle_text 
- _void_ **handle_text**() 
  
 Prepends a "+" to the text when the element is closed (collapsed) or a "-" when the element is
 visible (expanded).
  
---------
