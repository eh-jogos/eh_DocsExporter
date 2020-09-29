class_name JsonIO
extends EditorScript
# Write your doc striing for this file here

### Member Variables and Dependencies -----
# signals 
# enums
# constants
# public variables - order: export > normal var > onready 
# private variables - order: export > normal var > onready 
### ---------------------------------------


### Built in Engine Methods ---------------
func _ready():
	pass

### ---------------------------------------


### Public Methods ------------------------
### ---------------------------------------


### Private Methods -----------------------

func _push_reading_file_error(error, p_file_path) -> String:
	var msg: = "Error while reading %s: %s"%[p_file_path, error]
	push_error(msg)
	assert(false)
	return msg


func _push_parsing_file_error(error, p_file_path) -> String:
	var msg: = "Error while parsing %s's content: %s"%[p_file_path, error]
	push_error(msg)
	assert(false)
	return msg


func _get_dictionary_from_file(p_file_path) -> Dictionary:
	var dictionary: = {}
	var string_content: String = ""
	
	var file := File.new()
	var error = file.open(p_file_path, File.READ)
	if error != OK:
		dictionary["error"] = _push_reading_file_error(error, p_file_path)
	else:
		string_content = file.get_as_text()
		file.close()
		
		var parsed_json : = JSON.parse(string_content)
		if parsed_json.error != OK:
			dictionary["error"] = _push_parsing_file_error(error, p_file_path)
		else:
			dictionary = parsed_json.result
	
	return dictionary


func _write_dictionary_to_file(content: Dictionary, p_file_path: String) -> void:
	var formatted_file := File.new()
	var error = formatted_file.open(p_file_path, File.WRITE)
	if error != OK:
		_push_reading_file_error(error, p_file_path)
		return
	formatted_file.store_string(JSON.print(content, "  "))
	formatted_file.close()
	print("File Written to: %s"%[p_file_path])

### ---------------------------------------


