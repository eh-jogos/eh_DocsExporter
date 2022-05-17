# LineEdit for receiving file or folder paths. Has a small customization just to scroll the text
# to the end whenever a file or folder is selected through the File Explorer instead of typed in.
# @category: UI Elements
tool
class_name PathLineEdit
extends LineEdit

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------

### Public Methods --------------------------------------------------------------------------------

# Sets the text and scrolls it to the end position.
func set_text(string: String) -> void:
	text = string
	var total_chars = text.length()
	caret_position = total_chars-1

### -----------------------------------------------------------------------------------------------

### Private Methods -------------------------------------------------------------------------------

func _on_FileDialog_file_selected(path):
	set_text(path)


func _on_FileDialog_dir_selected(dir):
	set_text(dir)

### -----------------------------------------------------------------------------------------------
