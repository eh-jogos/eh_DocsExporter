---  
title: Shared Variables  
author: eh-jogos  
date: 2020-10-05T07:30:54-03:00  
weight: 5  
---  
Simple Custom Resources that can be saved to disk an represent only one variable of one type. Since Rsources are only loaded once and shared between all their references in code, it is used as some kind of shared variables so that the data it holds can be accessed and modified from multiple parts of the code and always stays in sync.

This ones are saved in a separate folder because they're all custom resources that represent basic types and can be reused between projects and different plugins, so that If you already have this folder from another plugin, you won't have any class_name conflicts and will only have to import the scripts you don't have.

In this plugin it is basically used so that you can edit data in the Docs Exporter Tab and have this data easily accessible by the code.

It is based on the idea of Unity's Scriptable Objects and Ryan Hipple's Unite Talk about architeting games around scriptable objects.  
Reference Links:
- [Text How To](https://unity.com/how-to/architect-game-code-scriptable-objects#architect-other-systems)
- [Unite Talk Video](https://www.youtube.com/watch?v=raQ3iHhE_Kk)
- [Ryans Example Repository](https://github.com/roboryantron/Unite2017)

TOC:  
- [ArrayVariable]({{< ref "/reference/shared variables/arrayvariable" >}})  
- [StringArrayVariable]({{< ref "/reference/shared variables/stringarrayvariable" >}})  
- [BoolVariable]({{< ref "/reference/shared variables/boolvariable" >}})  
- [DictionaryVariable]({{< ref "/reference/shared variables/dictionaryvariable" >}})  
- [StringVariable]({{< ref "/reference/shared variables/stringvariable" >}})  
- [StringVariableArray]({{< ref "/reference/shared variables/stringvariablearray" >}})  
