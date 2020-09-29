tool
class_name BoolVariable
extends Resource
# Write your doc striing for this file here

### Member Variables and Dependencies -----
# signals 

signal value_updated

# enums
# constants
# public variables - order: export > normal var > onready 

export var value: = true setget _set_value

# private variables - order: export > normal var > onready 
### ---------------------------------------


### Built in Engine Methods ---------------

### ---------------------------------------


### Public Methods ------------------------
### ---------------------------------------


### Private Methods -----------------------

func _set_value(p_value: bool) -> void:
	value = p_value
	ResourceSaver.save(resource_path, self)
	emit_signal("value_updated")

### ---------------------------------------
