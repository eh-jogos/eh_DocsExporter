tool
extends Button
# Write your doc striing for this file here

### Member Variables and Dependencies -----
# signals 
# enums
# constants
# public variables - order: export > normal var > onready 
export var window_title: = ""

# private variables - order: export > normal var > onready 
onready var _file_dialog: FileDialog = get_node("FileDialog")
### ---------------------------------------


### Built in Engine Methods ---------------
func _ready():
	_file_dialog.window_title = window_title


func _pressed() -> void:
	_file_dialog.popup_centered()
	
### ---------------------------------------


### Public Methods ------------------------
### ---------------------------------------


### Private Methods -----------------------
### ---------------------------------------


