# Script for columns that need to populate PoolStringArray fields.
tool
extends VBoxContainer

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

# value found by printing the resources property dict, but documented HINT constants 
# only go up to 22
const HINT_STRING_ARRAY = 24

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

export var _editor_field_packed_scene: PackedScene = null

var _property: String = ""
var _string_array: Array = []
var _possible_properties: PoolStringArray = PoolStringArray()

onready var _settings: eh_DocsSettings = eh_DocsExporterPlugin.get_doc_settings()
onready var _field_container: VBoxContainer = $Fields

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _ready():
	if eh_DocsExporterPlugin.is_current_edited_scene(self):
		return
	
	initialize_editor_fields()

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

func initialize_editor_fields() -> void:
	_string_array = _settings.get(_property)
	_populate_editor_fields()

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

# Populates with some kind of editor field that accepts a StringVariable, and gives each one it's
# respective StringVariable. Also takes care of showing the delete button when needed and
# connecting it to its function.
func _populate_editor_fields() -> void:
	for row in _field_container.get_children():
		_field_container.remove_child(row)
		row.queue_free()
	
	var row_count: = 0
	for value in _string_array:
		var editor_field: StringLineEdit = _editor_field_packed_scene.instance()
		_field_container.add_child(editor_field, true)
		editor_field.set_field_value(value, row_count)
		
		editor_field.connect("value_updated", self, "_on_editor_field_value_updated")
		if editor_field.is_removable:
			editor_field.connect("value_removed", self, "_on_editor_field_value_removed")
		
		row_count += 1


func _on_AddMore_pressed() -> void:
	_string_array.append("")
	_populate_editor_fields()


func _on_editor_field_value_updated(index: int, value: String) -> void:
	if index > _string_array.size():
		for new_index in range(_string_array.size(), index):
			_string_array.append("")
	
	_string_array[index] = value


func _on_editor_field_value_removed(index: int) -> void:
	_string_array.remove(index)
	_populate_editor_fields()

### -----------------------------------------------------------------------------------------------

###################################################################################################
# Editor Methods ##################################################################################
###################################################################################################

### Custom Inspector builçt in functions ----------------------------------------------------------

func _get_property_list() -> Array:
	var properties: = []
	
	_reload_settings_resource()
	_possible_properties = _get_possible_string_array_properties()
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
			_property = value
			has_handled = true
	
	return has_handled

### -----------------------------------------------------------------------------------------------


### Helpers ---------------------------------------------------------------------------------------

func _reload_settings_resource() -> void:
	if not _settings:
		_settings = eh_DocsExporterPlugin.get_doc_settings()


func _get_possible_string_array_properties() -> PoolStringArray:
	var string_array_properties: = PoolStringArray()
	
	var settings_properties: = _settings.get_property_list()
	for property_dict in settings_properties:
		if property_dict.type == TYPE_ARRAY and property_dict.hint == HINT_STRING_ARRAY:
			string_array_properties.append(property_dict.name)
	
	return string_array_properties

### -----------------------------------------------------------------------------------------------
