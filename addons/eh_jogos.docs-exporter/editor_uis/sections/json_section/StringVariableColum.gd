tool
extends VBoxContainer
# Write your doc striing for this file here

### Member Variables and Dependencies -----
# signals 
# enums
# constants
# public variables - order: export > normal var > onready 

export var button_text = ""

# private variables - order: export > normal var > onready
var _editor_field_packed_scene: PackedScene = null

onready var _resource_preloader: ResourcePreloader = $ResourcePreloader
onready var _field_container: VBoxContainer = $Fields
### ---------------------------------------


### Built in Engine Methods ---------------

func _ready():
	_editor_field_packed_scene = _resource_preloader.get_resource("editor_field")

### ---------------------------------------


### Public Methods ------------------------

func populate_editor_fields(fields: StringVariableArray) -> void:
	for field in fields.value:
		var string_variable = field as StringVariable
		var editor_field = _editor_field_packed_scene.instance()
		_field_container.add_child(editor_field, true)
		
		if editor_field.has_method("set_string_variable"):
			editor_field.set_string_variable(string_variable)

### ---------------------------------------


### Private Methods -----------------------
### ---------------------------------------


