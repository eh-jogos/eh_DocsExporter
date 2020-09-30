tool
extends VBoxContainer
# Write your doc striing for this file here

### Member Variables and Dependencies -----
# signals 
# enums
# constants
# public variables - order: export > normal var > onready 
# private variables - order: export > normal var > onready 

var _hugo_exporter: HugoMarkdownDocsExporter

var _save_path: StringVariable = null
var _export_path: StringVariable = null
var _categories_db : DictionaryVariable = null
var _optional_data_db: CategoryOptionalDataDict = null
var _category_options_packed_scene: PackedScene = null

onready var _resource_preloader = $ResourcePreloader
onready var _hugo_path_selector = $ExportPathRow/DirectorySystemPathLineEdit
onready var _category_button = $Categories
onready var _category_list = $CategoriesBlockIdent/CategoriesList

### ---------------------------------------


### Built in Engine Methods ---------------

func _ready() -> void:
	_hugo_exporter = HugoMarkdownDocsExporter.new()
	
	_save_path = _resource_preloader.get_resource("save_path")
	_export_path = _resource_preloader.get_resource("hugo_export_path")
	_categories_db = _resource_preloader.get_resource("category_db")
	_optional_data_db = _resource_preloader.get_resource("optional_data")
	_category_options_packed_scene = _resource_preloader.get_resource("category_options_line")
	
#	_optional_data_db.connect("value_updated", self, "_on_optional_data_db_value_updated")
	
	_hugo_path_selector.set_string_variable(_export_path)
	_populate_category_details_ui()

### ---------------------------------------


### Public Methods ------------------------
### ---------------------------------------


### Private Methods -----------------------

func _populate_category_details_ui() -> void:
	_clear_category_list()
	var valid_keys = _categories_db.value.keys()
	if valid_keys.empty() or _optional_data_db.value.empty():
		_category_button.hide()
	else:
		_category_button.show()
		valid_keys.sort()
		for key in valid_keys:
			if _optional_data_db.value.has(key):
				var options_node: CategoryOptions = _category_options_packed_scene.instance()
				_category_list.add_child(options_node, true)
				
				options_node.populate_category_entry(key, _optional_data_db.value[key])
				
	#			print("%s: %s"%[key, JSON.print(_optional_data_db.value[key], " ")])



func _clear_category_list():
	for child in _category_list.get_children():
		_category_list.remove_child(child)
		child.queue_free()


func _on_ExportHugoContent_pressed() -> void:
	_hugo_exporter.export_hugo_site_pages(_save_path.value, _export_path.value)


func _on_BuildCategoryDb_pressed() -> void:
	_hugo_exporter.build_category_db(_save_path.value, _export_path.value)
	_populate_category_details_ui()


func _on_HugoSection_focus_entered():
	_populate_category_details_ui()

### ---------------------------------------
