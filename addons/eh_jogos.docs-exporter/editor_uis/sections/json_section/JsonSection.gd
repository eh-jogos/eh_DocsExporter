# Json Section of the Project Settings Doc Exporter Tab.
tool
extends VBoxContainer

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

var _reference_formatter: ReferenceFormatter

var _directories: StringVariableArray = null
var _filters: StringVariableArray = null
var _is_recursive: BoolVariable = null
var _save_path: StringVariable = null

onready var _directories_column = $DirectoriesRow/DirectoriesColum
onready var _filters_column = $FiltersRow/FilterColumn
onready var _json_path_selector = $JsonReferenceRow/JsonPathSelector
onready var _resource_preloader = $ResourcePreloader

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _ready() -> void:
	_reference_formatter = ReferenceFormatter.new()
	
	_directories = _resource_preloader.get_resource("directories")
	_filters = _resource_preloader.get_resource("filters")
	_is_recursive = _resource_preloader.get_resource("is_recursive")
	_save_path = _resource_preloader.get_resource("save_path")
	
	_directories_column.populate_editor_fields(_directories)
	_filters_column.populate_editor_fields(_filters)
	_json_path_selector.set_string_variable(_save_path)

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _on_ExportJson_pressed() -> void:
	_reference_formatter.export_formatted_reference_json(
			_directories.get_string_array(),
			_filters.get_string_array(),
			_is_recursive.value,
			_save_path.value
	)

### -----------------------------------------------------------------------------------------------
