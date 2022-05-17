# TextEdit with a corner that can be dragged and resized. Used in different parts of the Docs 
# Exporter tab in the Project Settings.
# @category: UI Elements
tool
class_name ResizableTextEdit
extends TextEdit

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

var _initial_min_size = rect_min_size
var _initial_pos: = Vector2.ZERO
var _is_dragging: = false

onready var _drag_edge: TextureButton = $TextureButton

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _gui_input(event):
	var mouse_move = event is InputEventMouseMotion
	if mouse_move != null and _is_dragging:
		var difference = get_global_mouse_position() - _initial_pos
		var new_min_size_y: float = rect_min_size.y + difference.y
		
		if new_min_size_y >= _initial_min_size.y:
			_initial_pos = get_global_mouse_position()
			rect_min_size.y = new_min_size_y
		else:
			rect_min_size.y = _initial_min_size.y
		
		rect_size.y = rect_min_size.y

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _on_TextureButton_button_down():
	_initial_pos = get_global_mouse_position()
	_is_dragging = true


func _on_TextureButton_button_up():
	_is_dragging = false

### -----------------------------------------------------------------------------------------------
