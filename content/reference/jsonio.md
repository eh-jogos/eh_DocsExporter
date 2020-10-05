---  
title: JsonIO  
author: eh-jogos  
date: 2020-10-05T07:30:54-03:00  
weight: 1  
---  
**Inherits:** _[Reference](https://docs.godotengine.org/en/stable/classes/class_reference.html) > [Object](https://docs.godotengine.org/en/stable/classes/class_object.html)_  
**Inherited by:** _[MarkdownDocsExporter]({{< ref "/reference/markdowndocsexporter" >}}), [ReferenceFormatter]({{< ref "/reference/referenceformatter" >}})_  
  
## Description  
 Helper Class to read and write JSON files.
  
  
## Methods 
  
| return type | method signature |  
| ----------- | ---------------- |  
| [String](https://docs.godotengine.org/en/stable/classes/class_string.html) | **[push_reading_file_error]({{< ref "/reference/jsonio#push_reading_file_error" >}})**([Variant](https://docs.godotengine.org/en/stable/classes/class_variant.html) error, [Variant](https://docs.godotengine.org/en/stable/classes/class_variant.html) p_file_path) |  
| [String](https://docs.godotengine.org/en/stable/classes/class_string.html) | **[push_parsing_file_error]({{< ref "/reference/jsonio#push_parsing_file_error" >}})**([Variant](https://docs.godotengine.org/en/stable/classes/class_variant.html) error, [Variant](https://docs.godotengine.org/en/stable/classes/class_variant.html) p_file_path) |  
| [Dictionary](https://docs.godotengine.org/en/stable/classes/class_dictionary.html) | **[get_dictionary_from_file]({{< ref "/reference/jsonio#get_dictionary_from_file" >}})**([Variant](https://docs.godotengine.org/en/stable/classes/class_variant.html) p_file_path) |  
| [null](https://docs.godotengine.org/en/stable/classes/class_null.html) | **[write_dictionary_to_file]({{< ref "/reference/jsonio#write_dictionary_to_file" >}})**([Dictionary](https://docs.godotengine.org/en/stable/classes/class_dictionary.html) content, [String](https://docs.godotengine.org/en/stable/classes/class_string.html) p_file_path) |  
## Method Descriptions  
  
### push_reading_file_error 
- _[String](https://docs.godotengine.org/en/stable/classes/class_string.html)_ **push_reading_file_error**([Variant](https://docs.godotengine.org/en/stable/classes/class_variant.html) error, [Variant](https://docs.godotengine.org/en/stable/classes/class_variant.html) p_file_path) 
  
 Pushes error to Godot's debugger when there's a file reading error.
  
---------
### push_parsing_file_error 
- _[String](https://docs.godotengine.org/en/stable/classes/class_string.html)_ **push_parsing_file_error**([Variant](https://docs.godotengine.org/en/stable/classes/class_variant.html) error, [Variant](https://docs.godotengine.org/en/stable/classes/class_variant.html) p_file_path) 
  
 Pushes error to Godot's debugger when there's a file parsing error.
  
---------
### get_dictionary_from_file 
- _[Dictionary](https://docs.godotengine.org/en/stable/classes/class_dictionary.html)_ **get_dictionary_from_file**([Variant](https://docs.godotengine.org/en/stable/classes/class_variant.html) p_file_path) 
  
 Reads json file and return a parsed dictionary
  
---------
### write_dictionary_to_file 
- _void_ **write_dictionary_to_file**([Dictionary](https://docs.godotengine.org/en/stable/classes/class_dictionary.html) content, [String](https://docs.godotengine.org/en/stable/classes/class_string.html) p_file_path) 
  
 Writes dictionary into a json file.
  
---------
