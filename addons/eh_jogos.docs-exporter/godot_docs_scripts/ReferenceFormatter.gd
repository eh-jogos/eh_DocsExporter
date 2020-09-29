tool
class_name ReferenceFormatter
extends JsonIO
# Write your doc striing for this file here

### Member Variables and Dependencies -----
# signals 
# enums
# constants
const METADATA = {
	category = "\n @category:"
}

# public variables - order: export > normal var > onready 

# A list of directories to collect files from.
var directories := ["res://addons/eh_jogos_game_jolt_api"]
# If true, explore each directory recursively
var is_recursive: = true
# A list of patterns to filter files.
var patterns := ["*.gd"]
# Output path to save the class reference.
var save_path := "res://formated_reference.json"

# private variables - order: export > normal var > onready 

var _shared_variables_path = "res://addons/eh_jogos.docs-exporter/shared_variables/"
var _custom_class_db : DictionaryVariable
var _custom_inheritance_db : DictionaryVariable

### ---------------------------------------


### Built in Engine Methods ---------------
func _init():
	_custom_class_db = load(_shared_variables_path + "dict_custom_class_db.tres")
	_custom_inheritance_db = load(_shared_variables_path + "dict_custom_inheritance_db.tres")


func _run() -> void:
	export_formatted_reference_json(directories, patterns, is_recursive, save_path)

### ---------------------------------------


### Public Methods ------------------------

func export_formatted_reference_json(
		directories: Array, 
		patterns: Array, 
		is_recursive: bool, 
		save_path: String
) -> void:
	_build_custom_class_dbs()
	
	var reference_dict : = _build_reference_dictionary_from_source_code(
			directories, 
			patterns, 
			is_recursive
	)
	
	
	var formatted_reference : Dictionary = {
			name = reference_dict.name,
			description = reference_dict.description,
			version = reference_dict.version,
			classes = []
	}
	
	for class_entry in reference_dict.classes:
		if not class_entry.has("name") or class_entry.name == "":
			continue
		
		var parent_class : String = class_entry.extends_class[0]
		var full_inheritance : Array = _get_inheritance(parent_class)
		class_entry.extends_class = full_inheritance
		
		if _custom_inheritance_db.value.has(class_entry.name):
			class_entry["inherited_by"] = _custom_inheritance_db.value[class_entry.name]
		
		if class_entry.has("description"):
			_handle_metadata(class_entry)
		
		formatted_reference.classes.append(class_entry)
	
	_write_dictionary_to_file(formatted_reference, save_path)

### ---------------------------------------


### Private Methods -----------------------

func _build_custom_class_dbs() -> void:
	_custom_class_db.value.clear()
	_custom_inheritance_db.value.clear()
	
	var custom_classes_array : = []
	var config = ConfigFile.new()
	var err = config.load("res://project.godot")
	if err != OK:
		return
	
	custom_classes_array = config.get_value("", "_global_script_classes")
	for custom_class in custom_classes_array:
		_custom_class_db.value[custom_class.class] = custom_class.base
		if not ClassDB.class_exists(custom_class.base):
			if not _custom_inheritance_db.value.has(custom_class.base):
				_custom_inheritance_db.value[custom_class.base] = []
			_custom_inheritance_db.value[custom_class.base].append(custom_class.class)


func _build_reference_dictionary_from_source_code(
		directories: Array, 
		patterns: Array, 
		is_recursive: bool
) -> Dictionary:
	var Collector: SceneTree = \
			load("res://addons/eh_jogos.docs-exporter/godot_docs_scripts/Collector.gd").new()
	
	var files := PoolStringArray()
	for dirpath in directories:
		files.append_array(Collector.find_files(dirpath, patterns, is_recursive))
	var reference_dict : Dictionary = Collector.get_reference(files, true)
	Collector = null
	
	return reference_dict


func _get_inheritance(p_class: String) -> Array:
	var inheritance_array = [p_class]
	
	var parent_class = ""
	if ClassDB.class_exists(p_class):
		parent_class = ClassDB.get_parent_class(p_class)
	elif _custom_class_db.value.has(p_class):
		parent_class = _custom_class_db.value[p_class]
	
	if parent_class != "":
		var class_array: = _get_inheritance(parent_class)
		inheritance_array += class_array
	
	return inheritance_array


func _handle_metadata(class_entry: Dictionary) -> void:
	var description: String = class_entry.description
	
	for key in METADATA:
		var metadata_index = description.find(METADATA[key])
		if metadata_index != -1:
			var end_index = description.find("\n", metadata_index+1)
			var metadata_substring = description.substr(metadata_index, end_index-metadata_index)
			var metadata_value = metadata_substring.lstrip(METADATA[key])
			
			class_entry[key] = metadata_value
			class_entry.description = class_entry.description.replace(metadata_substring, "")

### ---------------------------------------
