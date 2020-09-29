tool
extends LineEdit
# Write your doc striing for this file here

### Member Variables and Dependencies -----
# signals 
# enums
# constants
# public variables - order: export > normal var > onready 
# private variables - order: export > normal var > onready 

var _string_variable: StringVariable = null
### ---------------------------------------


### Built in Engine Methods ---------------

### ---------------------------------------


### Public Methods ------------------------
func set_string_variable(resource: StringVariable) -> void:
	_string_variable = resource
	text = _string_variable.value
### ---------------------------------------


### Private Methods -----------------------

func _update_string_resource(value: String) -> void:
	_string_variable.value = value


func _on_StringVariableLineEdit_text_changed(new_text: String):
	_update_string_resource(new_text)


func _on_StringVariableLineEdit_text_entered(new_text: String):
	_update_string_resource(new_text)

### ---------------------------------------


