# Github Section of the Project Settings Doc Exporter Tab.
tool
extends VBoxContainer

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

var _gihub_exporter: MarkdownDocsExporter

onready var _settings: eh_DocsSettings = eh_DocsExporterPlugin.get_doc_settings()

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _ready() -> void:
	_gihub_exporter = MarkdownDocsExporter.new()

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

func _on_ExportGihubWiki_pressed() -> void:
	_gihub_exporter.export_github_wiki_pages(_settings.save_path, _settings.github_export_path)

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------
