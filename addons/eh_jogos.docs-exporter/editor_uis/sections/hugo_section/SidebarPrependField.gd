# Write your doc string for this file here
tool
extends ResizableTextEdit

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

var _string_data: StringVariable = null

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _ready():
	connect("text_changed", self, "_on_text_changed")

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

func set_string_variable(data: StringVariable) -> void:
	_string_data = data
	text = data.value

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _on_text_changed() -> void:
	_string_data.value = text

### -----------------------------------------------------------------------------------------------
