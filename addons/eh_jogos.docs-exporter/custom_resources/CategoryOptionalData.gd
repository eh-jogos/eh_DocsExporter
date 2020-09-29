# Struct to hold optional data for categories, like descriptions or weight to be used in HUGO
tool
class_name CategoryOptionalData
extends Resource

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

signal struct_updated

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

export var weight: = 0 setget _set_weight
export(String, MULTILINE) var description: = "" setget _set_description

#--- private variables - order: export > normal var > onready -------------------------------------

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _to_string() -> String:
	var as_string = {
		weight = weight,
		description = description
	}
	
	return "%s: %s"%[ get_instance_id(), JSON.print(as_string, " ")]

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _set_weight(value: int) -> void:
	weight = value
	_resource_updated()


func _set_description(value: String) -> void:
	description = value
	_resource_updated()


func _resource_updated() -> void:
	emit_signal("struct_updated")
	ResourceSaver.save(resource_path, self)

### -----------------------------------------------------------------------------------------------
