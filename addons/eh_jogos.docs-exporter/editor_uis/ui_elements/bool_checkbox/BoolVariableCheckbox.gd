# Editor Field for checkbox, associated with a respective [BoolVariable], used by the Docs
# Exporter tab in the Project Settings.
# @category: UI Elements
tool
class_name BoolVariableCheckbox
extends CheckBox

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

# BoolVariable responsible for serving as a shared variable for this option.
var bool_reference: BoolVariable = null

#--- private variables - order: export > normal var > onready -------------------------------------

export var _bool_variable: Resource = null

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _ready():
	bool_reference = _bool_variable as BoolVariable
	pressed = bool_reference.value
	_toggle_text()


func _toggled(button_pressed):
	bool_reference.value = button_pressed
	_toggle_text()

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _toggle_text():
	if pressed:
		text = "On"
	else:
		text = "Off"

### -----------------------------------------------------------------------------------------------


