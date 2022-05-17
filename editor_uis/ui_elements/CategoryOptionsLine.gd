# UI Element for the category optional data used by the Docs Exporter tab. 
# It's through these that the user of the addon will be
# able to customize the weight and description of the Hugo export for each category they create.
# 
# This element will be populated by a [CategoryOptionalData] resource which will handle the
# persistence and the sharing of this data with any part of the code that needs it. Anything filled
# in the Docs Exporter tab will be saved in the file 
# `res://addons/eh_jogos.docs-exporter/shared_variables/dict_categories_optional_data.tres`
# @category: UI Elements
tool
class_name CategoryOptions
extends VBoxContainer

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

onready var _data: CategoryOptionalData
onready var _category_name: Button = $CategoryName
onready var _weight_spin_box: SpinBox = $OptionsContent/MainColumn/WeightLine/SpinBox
onready var _description_text: TextEdit = \
		$OptionsContent/MainColumn/DescriptionContent/ResizableTextEdit

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

# Sets the [CategoryOptionalData] this element will be attached to and fill its fields with 
# their value.
func populate_category_entry(p_name: String, p_data: CategoryOptionalData) -> void:
	name = "%sOptions"%[p_name]
	_category_name.set_category_name(p_name)
	_data = p_data
	_weight_spin_box.value = _data.weight
	_description_text.text = _data.description
	
	_weight_spin_box.connect("value_changed", self, "_on_weight_spin_box_value_changed")
	_description_text.connect("text_changed", self, "_on_description_text_text_changed")

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _on_weight_spin_box_value_changed(value):
	_data.weight = value


func _on_description_text_text_changed():
	_data.description = _description_text.text

### -----------------------------------------------------------------------------------------------
