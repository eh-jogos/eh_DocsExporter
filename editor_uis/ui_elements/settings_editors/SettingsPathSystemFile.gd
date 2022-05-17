# Write your doc string for this file here
tool
extends HBoxContainer

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

const EXCLUDED_PROPERTIES = [
		"resource_path",
		"resource_name",
]

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

var _property: String = "" setget _set_property
var _possible_properties: PoolStringArray = PoolStringArray()

onready var _settings: eh_DocsSettings = eh_DocsExporterPlugin.get_doc_settings()

onready var _line_edit: LineEdit = $LineEdit
onready var _file_dialog: FileDialog = $FileExplorerButton/FileDialog

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _ready() -> void:
	if eh_DocsExporterPlugin.is_current_edited_scene(self):
		return
	
	_line_edit.text = _settings.get(_property)
	_update_filters_for_property()

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _set_property(value: String) -> void:
	_property = value


func _update_filters_for_property() -> void:
	var settings_properties: = _settings.CUSTOM_PROPERTIES
	for property_dict in settings_properties.values():
		if not property_dict.has("backing_field"):
			continue
		elif property_dict.backing_field == _property and property_dict.has("hint_string"):
			var filters = (property_dict.hint_string as String).split(",")
			_file_dialog.filters = PoolStringArray(filters)
			break


func _on_LineEdit_text_changed(new_text: String) -> void:
	_settings.set(_property, new_text)


func _on_LineEdit_text_entered(new_text: String) -> void:
	_settings.set(_property, new_text)


func _on_FileDialog_file_selected(path: String) -> void:
	_line_edit.text = path
	_settings.set(_property, path)

### -----------------------------------------------------------------------------------------------

###################################################################################################
# Editor Methods ##################################################################################
###################################################################################################

### Custom Inspector builçt in functions ----------------------------------------------------------

func _get_property_list() -> Array:
	var properties: = []
	
	_reload_settings_resource()
	_possible_properties = _get_possible_string_properties()
	var dict: Dictionary = eh_DocsSettings.get_property_drop_down(_possible_properties)
	properties.append(dict)
	
	return properties


func _get(property: String):
	var value
	
	match property:
		"property":
			if _property.empty():
				value = _possible_properties[0]
			else:
				value = _property
	
	return value


func _set(property: String, value) -> bool:
	var has_handled: = false
	
	match property:
		"property":
			_set_property(value)
			has_handled = true
	
	return has_handled

### -----------------------------------------------------------------------------------------------


### Helpers ---------------------------------------------------------------------------------------

func _reload_settings_resource() -> void:
	if not _settings:
		_settings = eh_DocsExporterPlugin.get_doc_settings()


func _get_possible_string_properties() -> PoolStringArray:
	var value: = PoolStringArray()
	
	var settings_properties: = _settings.get_property_list()
	for property_dict in settings_properties:
		if property_dict.name in EXCLUDED_PROPERTIES:
			continue
		
		if property_dict.type == TYPE_STRING and property_dict.hint == PROPERTY_HINT_GLOBAL_FILE:
			value.append(property_dict.name)
	
	return value

### -----------------------------------------------------------------------------------------------
