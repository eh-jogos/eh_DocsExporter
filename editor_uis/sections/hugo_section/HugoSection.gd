# Hugo Section of the Project Settings Doc Exporter Tab.
tool
extends VBoxContainer

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

export var _category_options_packed_scene: PackedScene = null

var _hugo_exporter: HugoMarkdownDocsExporter

onready var _category_button = $Categories
onready var _category_list = $CategoriesBlockIdent/CategoriesList

onready var _settings: eh_DocsSettings = eh_DocsExporterPlugin.get_doc_settings()

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------

func _ready() -> void:
	if eh_DocsExporterPlugin.is_current_edited_scene(self):
		return
	
	_hugo_exporter = HugoMarkdownDocsExporter.new()
	
	_populate_category_details_ui()

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _populate_category_details_ui() -> void:
	_clear_category_list()
	var valid_keys = _settings.db_categories.keys()
	if valid_keys.empty() or _settings.hugo_optional_data.empty():
		_category_button.hide()
	else:
		_category_button.show()
		valid_keys.sort()
		for key in valid_keys:
			if _settings.hugo_optional_data.has(key):
				var options_node: CategoryOptions = _category_options_packed_scene.instance()
				_category_list.add_child(options_node, true)
				
				options_node.populate_category_entry(key, _settings.hugo_optional_data[key])
				
	#			print("%s: %s"%[key, JSON.print(_optional_data_db.value[key], " ")])


func _clear_category_list():
	for child in _category_list.get_children():
		_category_list.remove_child(child)
		child.queue_free()


func _on_ExportHugoContent_pressed() -> void:
	_hugo_exporter.export_hugo_site_pages(_settings.save_path, _settings.hugo_export_path)


func _on_BuildCategoryDb_pressed() -> void:
	_hugo_exporter.build_category_db(_settings.save_path, _settings.hugo_export_path)
	_populate_category_details_ui()


func _on_HugoSection_focus_entered():
	_populate_category_details_ui()

### -----------------------------------------------------------------------------------------------
