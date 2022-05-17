tool
class_name eh_DocsExporterPlugin
extends EditorPlugin

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

const PATH_TAB = \
		"res://addons/eh_jogos.docs-exporter/editor_uis/DocsExporterProjectSettingsTab.tscn"
const PATH_SETTINGS_RESOURCE = "res://addons/eh_jogos.docs-exporter/docs_settings.tres"

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

var _settings: eh_DocsSettings

var _docs_exporter_tab: Control

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func enable_plugin() -> void:
	_create_docs_settings_resource()

func _enter_tree():
	_reload_setting_resource()
	_docs_exporter_tab = load(PATH_TAB).instance()
	add_control_to_container(
			EditorPlugin.CONTAINER_PROJECT_SETTING_TAB_RIGHT, 
			_docs_exporter_tab
	)


func _exit_tree():
	remove_control_from_container(
			EditorPlugin.CONTAINER_PROJECT_SETTING_TAB_RIGHT, 
			_docs_exporter_tab
	)
	_docs_exporter_tab.free()
	pass


func save_external_data() -> void:
	_reload_setting_resource()
	ResourceSaver.save(PATH_SETTINGS_RESOURCE, _settings)

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

static func get_doc_settings() -> eh_DocsSettings:
	var settings: eh_DocsSettings = load(PATH_SETTINGS_RESOURCE)
	return settings


static func is_current_edited_scene(root_node: Node) -> bool:
	var value: bool = Engine.editor_hint
	
	if value:
		var editor_script: = EditorScript.new()
		var editor_interface = editor_script.get_editor_interface()
		value = editor_interface.get_edited_scene_root() == root_node
	
	return value

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _create_docs_settings_resource() -> void:
	if not ResourceLoader.exists(PATH_SETTINGS_RESOURCE):
		_settings = eh_DocsSettings.new()
		ResourceSaver.save(PATH_SETTINGS_RESOURCE, _settings)


func _reload_setting_resource() -> void:
	if not _settings:
		_create_docs_settings_resource()
		_settings = load(PATH_SETTINGS_RESOURCE)

### -----------------------------------------------------------------------------------------------
