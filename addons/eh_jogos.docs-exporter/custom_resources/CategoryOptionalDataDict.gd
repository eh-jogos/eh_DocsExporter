# Dictionary of [CategoryOptionalData], to be saved in disk and used somewhat like a database by the
# plugin. This is what allows it to show the relevant fields in the Docs Exporter tab.
#
# If you rename a category and the description disappears, look for the file in 
# `res://addons/eh_jogos.docs-exporter/shared_variables/dict_categories_optional_data.tres` and it
# will still hold the description inside a key with the name of the old category.
# @category: Custom Resources
tool
class_name CategoryOptionalDataDict
extends Resource

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

# signal emitted whenever the dictionary changes.
signal value_updated

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

# Dictionary that only accepts [CategoryOptionalData] as values.
export var value: Dictionary = {} setget _set_value, _get_value

#--- private variables - order: export > normal var > onready -------------------------------------

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _set_value(p_value: Dictionary) -> void:
	var keys_to_delete = value.keys()
	for key in p_value:
		var category_data: CategoryOptionalData = p_value[key]
		if category_data != null:
			value[key] = category_data
			if not category_data.is_connected("struct_updated", self, "_on_key_struct_updated"):
				category_data.connect("struct_updated", self, "_on_key_struct_updated")
			
			if keys_to_delete.has(key):
				keys_to_delete.erase(key)
	
	if keys_to_delete.size() > 0:
		for key in keys_to_delete:
			value.erase(key)
	
	_save_and_notify()


func _get_value() -> Dictionary:
	for element in value.keys():
		var category_data: CategoryOptionalData = value[element]
		if not category_data.is_connected("struct_updated", self, "_on_key_struct_updated"):
			category_data.connect("struct_updated", self, "_on_key_struct_updated")
	
	return value


func _save_and_notify():
	ResourceSaver.save(resource_path, self)
	emit_signal("value_updated")


func _on_key_struct_updated():
	_save_and_notify()

### -----------------------------------------------------------------------------------------------
