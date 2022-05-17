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

onready var _directories_column = $DirectoriesRow/DirectoriesColum
onready var _filters_column = $FiltersRow/FilterColumn

onready var _settings: eh_DocsSettings = eh_DocsExporterPlugin.get_doc_settings()

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _ready() -> void:
	_reference_formatter = ReferenceFormatter.new()

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _on_ExportJson_pressed() -> void:
	_reference_formatter.export_formatted_reference_json(
			_settings.directories,
			_settings.filters,
			_settings.is_recursive,
			_settings.save_path
	)

### -----------------------------------------------------------------------------------------------
