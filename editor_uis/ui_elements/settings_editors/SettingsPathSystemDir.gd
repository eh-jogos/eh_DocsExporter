# Write your doc string for this file here
tool
extends "res://addons/eh_jogos.docs-exporter/editor_uis/ui_elements/settings_editors/SettingsPathSystemFile.gd"

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _ready():
	pass

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _get_possible_string_properties() -> PoolStringArray:
	var value: = PoolStringArray()
	
	var settings_properties: = _settings.get_property_list()
	for property_dict in settings_properties:
		if property_dict.name in EXCLUDED_PROPERTIES:
			continue
		
		if property_dict.type == TYPE_STRING and property_dict.hint == PROPERTY_HINT_GLOBAL_DIR:
			value.append(property_dict.name)
	
	return value

### -----------------------------------------------------------------------------------------------
