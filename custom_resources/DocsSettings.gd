# Holds all the configuration data for correctly exporting the documentation.
tool
class_name eh_DocsSettings
extends Resource

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

const HIDDEN_HINTS = {
	"ArrayHint": 24,
}

const HIDDEN_HINT_STRING = {
	"ArrayString": 4,
	"ArrayDir": 14,
	"ArrayMultiline": 18,
}

#--- public variables - order: export > normal var > onready --------------------------------------

# Json Configs
var directories: Array = [] setget _set_directories
var filters: Array = []
var is_recursive: bool = true
var save_path: String = ""

# Github Configs
var github_export_path: String = ""
var github_sidebar_prepend: String = ""

# Hugo Configs
var hugo_export_path: String = ""
var hugo_optional_data: Dictionary = {}

# Internal Databases
var db_custom_classes: Dictionary = {}
var db_custom_inheritance: Dictionary = {}
var db_categories: Dictionary = {}

#--- private variables - order: export > normal var > onready -------------------------------------

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _set_directories(value: Array) -> void:
	if value.empty():
		value = [""]
	directories = value

### -----------------------------------------------------------------------------------------------


### Helpers ---------------------------------------------------------------------------------------

static func get_property_drop_down(possible_properties: PoolStringArray) -> Dictionary:
	var hint_string: String = possible_properties.join(",")
	hint_string = "%s,%s"%["none", hint_string]
	
	var dict: = {
		name = "property",
		type = TYPE_STRING,
		hint = PROPERTY_HINT_ENUM,
		hint_string = hint_string,
		usage = PROPERTY_USAGE_DEFAULT
	}
	return dict

### -----------------------------------------------------------------------------------------------

###################################################################################################
# Editor Methods ##################################################################################
###################################################################################################

const CUSTOM_PROPERTIES = {
	"general_category": {
		name = "General Options",
		type = TYPE_NIL,
		usage = PROPERTY_USAGE_CATEGORY,
	},
	"_directories": {
		backing_field = "directories",
		type = TYPE_ARRAY,
		usage = PROPERTY_USAGE_DEFAULT,
		hint = HIDDEN_HINTS.ArrayHint,
		hint_string = "%s/%s:"%[HIDDEN_HINT_STRING.ArrayString, HIDDEN_HINT_STRING.ArrayDir],
	},
	"_filters": {
		backing_field = "filters",
		type = TYPE_ARRAY,
		usage = PROPERTY_USAGE_DEFAULT,
		hint = HIDDEN_HINTS.ArrayHint,
		hint_string = "%s:"%[HIDDEN_HINT_STRING.ArrayString],
	},
	"_is_recursive": {
		backing_field = "is_recursive",
		type = TYPE_BOOL,
		usage = PROPERTY_USAGE_DEFAULT,
	},
	"_save_path": {
		backing_field = "save_path",
		type = TYPE_STRING,
		usage = PROPERTY_USAGE_DEFAULT,
		hint = PROPERTY_HINT_FILE,
		hint_string = "*.json",
	},
	"github_category": {
		name = "Github Options",
		type = TYPE_NIL,
		usage = PROPERTY_USAGE_CATEGORY,
	},
	"_github_export_path": {
		backing_field = "github_export_path",
		type = TYPE_STRING,
		usage = PROPERTY_USAGE_DEFAULT,
		hint = PROPERTY_HINT_GLOBAL_DIR,
	},
	"_github_sidebar_prepend": {
		backing_field = "github_sidebar_prepend",
		type = TYPE_STRING,
		usage = PROPERTY_USAGE_DEFAULT,
		hint = PROPERTY_HINT_MULTILINE_TEXT,
	},
	"hugo_category": {
		name = "Hugo Options",
		type = TYPE_NIL,
		usage = PROPERTY_USAGE_CATEGORY,
	},
	"_hugo_export_path": {
		backing_field = "hugo_export_path",
		type = TYPE_STRING,
		usage = PROPERTY_USAGE_DEFAULT,
		hint = PROPERTY_HINT_GLOBAL_DIR,
	},
	"_hugo_optional_data": {
		backing_field = "hugo_optional_data",
		type = TYPE_DICTIONARY,
		usage = PROPERTY_USAGE_DEFAULT,
	},
	"_internal_category": {
		name = "Internal Databases",
		type = TYPE_NIL,
		usage = PROPERTY_USAGE_CATEGORY,
	},
	"_db_custom_classes": {
		backing_field = "db_custom_classes",
		type = TYPE_DICTIONARY,
		usage = PROPERTY_USAGE_STORAGE,
	},
	"_db_custom_inheritance": {
		backing_field = "db_custom_inheritance",
		type = TYPE_DICTIONARY,
		usage = PROPERTY_USAGE_STORAGE,
	},
	"_db_categories": {
		backing_field = "db_categories",
		type = TYPE_DICTIONARY,
		usage = PROPERTY_USAGE_STORAGE,
	},
#	"": {
#		backing_field = "",
#		name = "",
#		type = TYPE_NIL,
#		usage = PROPERTY_USAGE_DEFAULT,
#		hint = PROPERTY_HINT_NONE,
#		hint_string = "",
#	},
}

### Custom Inspector built in functions -----------------------------------------------------------

func _get_property_list() -> Array:
	var properties: = []
	
	for key in CUSTOM_PROPERTIES:
		var dict: Dictionary = CUSTOM_PROPERTIES[key]
		if not dict.has("name"):
			dict.name = key
		properties.append(dict)
	
	return properties


func _get(property: String):
	var value
	
	if property in CUSTOM_PROPERTIES and CUSTOM_PROPERTIES[property].has("backing_field"):
		value = get(CUSTOM_PROPERTIES[property]["backing_field"])
	
	return value


func _set(property: String, value) -> bool:
	var has_handled: = false
	
	if property in CUSTOM_PROPERTIES and CUSTOM_PROPERTIES[property].has("backing_field"):
		set(CUSTOM_PROPERTIES[property]["backing_field"], value)
		has_handled = true
	
	return has_handled

### -----------------------------------------------------------------------------------------------


### Custom Inspector Private functions ------------------------------------------------------------

### -----------------------------------------------------------------------------------------------
