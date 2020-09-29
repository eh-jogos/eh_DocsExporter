# Dictionary of CategoryOptionalData, to be saved in disk and used somewhat like a database.
tool
class_name CategoryOptionalDataDict
extends Resource

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

signal value_updated

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

export var value: Dictionary = {} setget _set_value

#--- private variables - order: export > normal var > onready -------------------------------------

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------


func _set_value(p_value: Dictionary) -> void:
	value.clear()
	for key in p_value:
		var category_data: CategoryOptionalData = p_value[key]
		if category_data != null:
			value[key] = category_data
			if not category_data.is_connected("struct_updated", self, "_on_key_struct_updated"):
				category_data.connect("struct_updated", self, "_on_key_struct_updated")
	
	_save_and_notify()


func _save_and_notify():
	ResourceSaver.save(resource_path, self)
	emit_signal("value_updated")


func _on_key_struct_updated():
	_save_and_notify()

### -----------------------------------------------------------------------------------------------
