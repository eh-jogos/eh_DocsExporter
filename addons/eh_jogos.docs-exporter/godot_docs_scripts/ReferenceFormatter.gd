# Sweepes the project and generates the json reference for the codebase. Started this based on 
# ReferenceCollector.gd from GDQuest's docs maker, but customized it to add to the json some more
# information I wanted to use.
tool
class_name ReferenceFormatter
extends JsonIO

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

# Currently recognized metadata that you can use in the comments, while documenting your code.
# `@category:` - will group pages during export, and save them together in a folder with the same
# name as the category. If you want to use subcategories you can treat it as path. For example
# `# @category: CategoryA/SubcategoryB` will generate a folder named "CategoryA" and inside it 
# a folder named "SubcategoryB". Only works in the main description for the file.
const METADATA = {
	category = "@category:"
}

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

var _settings: eh_DocsSettings = eh_DocsExporterPlugin.get_doc_settings()

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _init():
	pass

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

# Sweepes the folders you set in `directories` looking for files that matches the provided 
# `patterns`. It can search the folders recursively or not, and resulting json is exported 
# to save_path.
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
		
		if _settings.db_custom_inheritance.has(class_entry.name):
			class_entry["inherited_by"] = _settings.db_custom_inheritance[class_entry.name]
		
		if class_entry.has("description"):
			_handle_metadata(class_entry)
		
		formatted_reference.classes.append(class_entry)
	
	write_dictionary_to_file(formatted_reference, save_path)

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _build_custom_class_dbs() -> void:
	_settings.db_custom_classes.clear()
	_settings.db_custom_inheritance.clear()
	
	var custom_classes_array : = []
	var config = ConfigFile.new()
	var err = config.load("res://project.godot")
	if err != OK:
		return
	
	custom_classes_array = config.get_value("", "_global_script_classes")
	for custom_class in custom_classes_array:
		_settings.db_custom_classes[custom_class.class] = custom_class.base
		if not ClassDB.class_exists(custom_class.base):
			if not _settings.db_custom_inheritance.has(custom_class.base):
				_settings.db_custom_inheritance[custom_class.base] = []
			_settings.db_custom_inheritance[custom_class.base].append(custom_class.class)


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
	elif _settings.db_custom_classes.has(p_class):
		parent_class = _settings.db_custom_classes[p_class]
	
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
			var metadata_value = metadata_substring.lstrip(METADATA[key]).strip_edges()
			
			class_entry[key] = metadata_value
			class_entry.description = class_entry.description.replace(metadata_substring, "")

### -----------------------------------------------------------------------------------------------
