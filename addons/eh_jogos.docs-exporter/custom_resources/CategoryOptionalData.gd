# Struct to hold optional data for categories, like descriptions or weight to be used in HUGO
# @category: Custom Resources
tool
class_name CategoryOptionalData
extends Resource

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

# Signal emitted whenever any struct variable is changed.
signal struct_updated

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

# Value hugo will use to order categories in the side menu. "Heavier" categories will appear to 
# the bottom and "lighter" ones will appear towards the top. Be careful though that "0" means 
# "disabled" so if you start setting weights for some categories set the ones you want to be on top
# with at least a value of "1"
#
# Can be filled in through the Docs exporter tab, in the Project Settings.
export var weight: int = 0 setget _set_weight

# Each category page gets a TOC with all the links that are inside it. If you want this auto 
# generated page to have a description as well, use this field. 
#
# Can be filled in through the Docs exporter tab, in the Project Settings.
export(String, MULTILINE) var description: String = "" setget _set_description

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
