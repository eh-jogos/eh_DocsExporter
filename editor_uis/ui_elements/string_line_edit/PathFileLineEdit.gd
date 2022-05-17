# Base class for any kind of PathLineEdit field. Receives a [String], which will be 
# responsible not only for the persistence of the data as well as sharing it with any part
# of the project that needs it.
#
# In the addon there are 3 Scenes for different kind of paths that are used in the Docs Exporter
# tab, one for file paths in the file system, one for directories in the project, and another for
# directories in the file system.
# @category: UI Elements
tool
class_name FilePathLineEdit
extends StringLineEdit

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

# Filters for the File Explorer window.
export var file_dialog_filter: = ""

#--- private variables - order: export > normal var > onready -------------------------------------

onready var _file_dialog: FileDialog = $FileExplorerButton/FileDialog

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _ready() -> void:
	if file_dialog_filter != "":
		_file_dialog.add_filter(file_dialog_filter)

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _on_FileDialog_file_selected(path: String) -> void:
	_line_edit.text = path
	_update_value(path)


func _on_FileDialog_dir_selected(dir: String) -> void:
	_line_edit.text = dir
	_update_value(dir)

### -----------------------------------------------------------------------------------------------
