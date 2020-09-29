tool
extends LineEdit
# Write your doc striing for this file here

### Member Variables and Dependencies -----
# signals 
# enums
# constants
# public variables - order: export > normal var > onready 
# private variables - order: export > normal var > onready 
### ---------------------------------------


### Built in Engine Methods ---------------

### ---------------------------------------


### Public Methods ------------------------

func set_text(string: String) -> void:
	text = string
	var total_chars = text.length()
	caret_position = total_chars-1

### ---------------------------------------


### Private Methods -----------------------
func _on_FileDialog_file_selected(path):
	set_text(path)


func _on_FileDialog_dir_selected(dir):
	set_text(dir)

### ---------------------------------------

