# Write your doc string for this file here
tool
extends LineEdit

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

var _property: String = ""
var _possible_properties: PoolStringArray = PoolStringArray()

onready var _settings: eh_DocsSettings = eh_DocsExporterPlugin.get_doc_settings()

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _ready() -> void:
	if eh_DocsExporterPlugin.is_current_edited_scene(self):
		return
	
	text = _settings.get(_property)

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _on_LineEdit_text_changed(new_text: String) -> void:
	_settings.set(_property, new_text)


func _on_LineEdit_text_entered(new_text: String) -> void:
	_settings.set(_property, new_text)

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
			_property = value
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
		
		if property_dict.type == TYPE_STRING:
			value.append(property_dict.name)
	
	return value

### -----------------------------------------------------------------------------------------------
