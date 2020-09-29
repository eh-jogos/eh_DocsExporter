# Write your doc string for this file here
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
onready var category_name: Button = $CategoryName
onready var weight_spin_box: SpinBox = $OptionsContent/MainColumn/WeightLine/SpinBox
onready var description_text: TextEdit = \
		$OptionsContent/MainColumn/DescriptionContent/ResizableTextEdit

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

func populate_category_entry(p_name: String, p_data: CategoryOptionalData) -> void:
	name = "%sOptions"%[p_name]
	category_name.set_category_name(p_name)
	_data = p_data
	weight_spin_box.value = _data.weight
	description_text.text = _data.description
	
	weight_spin_box.connect("value_changed", self, "_on_weight_spin_box_value_changed")
	description_text.connect("text_changed", self, "_on_description_text_text_changed")

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _on_weight_spin_box_value_changed(value):
	_data.weight = value


func _on_description_text_text_changed():
	_data.description = description_text.text

### -----------------------------------------------------------------------------------------------
