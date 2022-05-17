# Scene for simple [String]s. May be used for simple Strings or for String Arrays, includes a 
# delete button for when it's used as part of a String Array UI.
# @category: UI Elements
tool
class_name StringLineEdit
extends HBoxContainer

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

signal value_updated(string, index)
signal value_removed(index)

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

# Option to turn on/off the remove field button.
export var is_removable: = false setget _set_is_removable

#--- private variables - order: export > normal var > onready -------------------------------------

var _index: int = -1

onready var _line_edit: LineEdit = $ValueLineEdit
onready var _delete_button: Button = $DeleteButton

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

func set_field_value(value: String, index: int = -1) -> void:
	_line_edit.set_text(value)
	_index = index
	
	if _index <= 0:
		_set_is_removable(false)
	else:
		_set_is_removable(true)

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _set_is_removable(value: bool) -> void:
	is_removable = value
	
	if not is_inside_tree():
		yield(self, "ready")
	
	_delete_button.visible = value


func _update_value(value: String) -> void:
	emit_signal("value_updated", value, _index)


func _on_ValueLineEdit_text_entered(new_text: String) -> void:
	_update_value(new_text)


func _on_ValueLineEdit_text_changed(new_text: String) -> void:
	_update_value(new_text)


func _on_DeleteButton_pressed():
	emit_signal("value_removed", _index)

### -----------------------------------------------------------------------------------------------
