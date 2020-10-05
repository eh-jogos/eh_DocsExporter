# Component with collapsible behavior to easily be attached to any UI needs.
# It takes two variables, the NodePath for a text element which will be handled to give feedback 
# for collapsible options or state, and a NodePath for the node that must be toggled when 
# collapsed. 
#
# If attached directly to a Button of any kind, it will auto connect with the "pressed" signal.
# If this behavior is not desirable, just uncheck the option `should_auto_connect`
# @category: Components
tool
class_name Collapsible
extends Node

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

# NodePath for the feedback text.
export var text_element_path: = NodePath()
# NodePath for the node that must be toggled on/off when collapsed.
export var collapsible_node_path: = NodePath()
# Turn this off if you don't want the component to try to auto connect with the pressed signal
# of the parent, in case the parent is a Button.
export var should_auto_connect: = true

#--- private variables - order: export > normal var > onready -------------------------------------

onready var _text_element: Control = get_node(text_element_path) 
onready var _collapsible: CanvasItem = get_node(collapsible_node_path)

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _ready():
	if _collapsible == null or _text_element == null:
		queue_free()
		return
	
	if should_auto_connect:
		if get_parent() is BaseButton:
			if not get_parent().is_connected("pressed", self, "_on_parent_pressed"):
				get_parent().connect("pressed", self, "_on_parent_pressed")
	
	handle_text()
	if not _collapsible.is_connected("ready", self, "_on_collapsible_ready"):
		_collapsible.connect("ready", self, "_on_collapsible_ready")

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

# Will collapse/expand the target node, and also trigger a change in the text as additional
# feedback
func toggle_collapse() -> void:
	_collapsible.visible = not _collapsible.visible
	handle_text()


# Prepends a "+" to the text when the element is closed (collapsed) or a "-" when the element is
# visible (expanded).
func handle_text() -> void:
	var is_open = _collapsible.visible
	if "text" in _text_element:
		var text: String = _text_element.text
		if is_open:
			if text.begins_with("+"):
				text = "-" + text.right(1)
			elif not text.begins_with("-"):
				text = "- " + text
		else:
			if text.begins_with("-"):
				text = "+" + text.right(1)
			elif not text.begins_with("+"):
				text = "+ " + text
		
		_text_element.text = text


### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _on_collapsible_ready() -> void:
	handle_text()


func _on_parent_pressed() -> void:
	toggle_collapse()

### -----------------------------------------------------------------------------------------------
