# Main markdown exporter. It exports using github flavor markdown. These .md files can be used
# anywhere, but the links and the _Sidebar.md are configured to work best with github wiki 
# format.
tool
class_name MarkdownDocsExporter
extends JsonIO

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

# Defines the "ineritance" block content model and styling for the exported .md file.
const MD_BLOCK_INHERITANCE = ""\
		+"**Inherits:** _{inheritance}_  \n"

# Defines the "inerited by" block content model and styling for the exported .md file.
const MD_BLOCK_INHERITED_BY = ""\
		+"**Inherited by:** _{inherited_by}_  \n"\
		+"  \n"

# Defines the "Description" block content model and styling for the exported .md file.
const MD_BLOCK_DESCRIPTION = ""\
		+"## Description  \n"\
		+"{description}"\
		+"  \n"

# Defines the "Properties" table header content model and styling for the exported .md file.
const MD_BLOCK_PROPERTIES_TABLE_TITLE = ""\
		+"## Properties \n"\
		+"  \n"\
		+"| type | property | default value |  \n"\
		+"| ---- | -------- | ------------- |  \n" 

# Defines the property table lines content model and styling for the exported .md file.
const MD_BLOCK_PROPERTIES_TABLE_LINE = ""\
		+"| {type} | {name} | {default_value} |  \n"

# Defines the "Methods" table header content model and styling for the exported .md file.
const MD_BLOCK_METHODS_TABLE_TITLE = ""\
		+"  \n"\
		+"## Methods \n"\
		+"  \n"\
		+"| return type | method signature |  \n"\
		+"| ----------- | ---------------- |  \n" 

# Defines the method table lines content model and styling for the exported .md file.
const MD_BLOCK_METHOD_TABLE_LINE = ""\
		+"| {type} | {siganture} |  \n"

# Defines the "Signals" header content model and styling for the exported .md file.
const MD_BLOCK_SIGNALS_TITLE = ""\
		+"  \n"\
		+"## Signals  \n"\
		+"  \n"

# Defines the individial signal content model and styling for the exported .md file.
const MD_BLOCK_SIGNALS_LINE = ""\
		+"- **{name}**({arguments}) \n"\
		+"  \n"\
		+"{description}  \n"\
		+"---------\n"

# Defines the "Enumerations" header content model and styling for the exported .md file.
const MD_BLOCK_ENUMS_TITLE = ""\
		+"  \n"\
		+"## Enumerations  \n"\
		+"  \n"

# Defines the individial enum name content model and styling for the exported .md file.
const MD_BLOCK_ENUM_NAME_LINE = ""\
		+"  \n"\
		+"enum **{name}**: \n"\
		+"  \n"

# Defines the individial enum keys content model and styling for the exported .md file.
const MD_BLOCK_ENUM_KEY_LINE = ""\
		+"- **{signature}**  \n"

# Defines the "Constants" header content model and styling for the exported .md file.
const MD_BLOCK_CONSTANTS_TITLE = ""\
		+"  \n"\
		+"## Constants  \n"\
		+"  \n"

# Defines the individial constant content model and styling for the exported .md file.
const MD_BLOCK_CONSTANTS_LINE = ""\
		+"- **{signature}** --- {description} \n"

# Defines the "Properties Descriptions" header content model and styling for the exported
# .md file.
const MD_BLOCK_PROPERTIES_DESCRIPTION = ""\
		+"  \n"\
		+"## Properties Descriptions  \n"\
		+"  \n"

# Defines the individial property definition content model and styling for the exported
# .md file.
const MD_BLOCK_PROPERTY = ""\
		+"### {name} \n"\
		+"- {property_signature}  \n"\
		+"  \n"\
		+"{table}"\
		+"{description}  \n"\
		+"---------\n"

# Defines the "Method Descriptions" header content model and styling for the exported
# .md file.
const MD_BLOCK_METHOD_DESCRIPTION = ""\
		+"## Method Descriptions  \n"\
		+"  \n"

# Defines the individial method definition content model and styling for the exported
# .md file.
const MD_BLOCK_METHOD = ""\
		+"### {name} \n"\
		+"- {method_signature} \n"\
		+"  \n"\
		+"{description}  \n"\
		+"---------\n"

# Godot's Documentatiion base url for forming links.
const GODOT_DOCS_BASE_URL = "https://docs.godotengine.org/en/stable/classes/class_%s.html"

#--- public variables - order: export > normal var > onready --------------------------------------

# Dictionary that serves as database for links and is built during the json export process
var links_db: Dictionary = {}

# Dictionary that serves as database for properties and methods signatures and is built during 
# the json export process
var signatures_db: Dictionary = {}

# If which key from the links database the exporter should use. Github exporter will use 
# "local_path" which just consists of repeating the file name, without extesnion. 
# Hugo exporter will use "full_path" which will take folder structure into account.
var key_to_use_for_link: String

#--- private variables - order: export > normal var > onready -------------------------------------

var _shared_variables_path = "res://addons/eh_jogos.docs-exporter/shared_variables/"
var _custom_class_db : DictionaryVariable
var _custom_inheritance_db : DictionaryVariable
var _built_in_type_db : StringArrayVariable
var _category_optional_data: CategoryOptionalDataDict
var _category_db: DictionaryVariable
var _sidebar_prepend: StringVariable

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _init():
	_custom_class_db = load(_shared_variables_path + "dict_custom_class_db.tres")
	_custom_inheritance_db = load(_shared_variables_path + "dict_custom_inheritance_db.tres")
	_category_db = load(_shared_variables_path + "dict_category_db.tres")
	_built_in_type_db = load(_shared_variables_path + "array_built_in_type_db.tres")
	_category_optional_data = load(_shared_variables_path + "dict_categories_optional_data.tres")
	_sidebar_prepend = load(_shared_variables_path + "string_sidebar_prepend_content.tres")
	
	key_to_use_for_link = "local_path"

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

# Reads json reference and creates a category database with the current user defined categories 
# in use.
func build_category_db(reference_json_path: String, export_path: String):
	var keys_start = _category_db.value.keys()
	var keys_end: = []
	var reference_dict : = get_dictionary_from_file(reference_json_path)
	if reference_dict.has("error"):
		push_error(reference_dict.error)
		return
	
	for entry in reference_dict.classes:
		var category: String = entry.category if entry.has("category") else ""
		keys_end += _add_to_category_db(category, entry.name, export_path)
	
	for key in keys_start:
		if not keys_end.has(key):
			_category_db.value.erase(key)
	
#	print("PRINTING _category_db: %s"%[JSON.print(_category_db.value, "  ")])


# Takes in the reference json file path and an export path and generates and exports github wiki 
# formatted .md files.
func export_github_wiki_pages(reference_json_path: String, export_path: String) -> void:
	build_category_db(reference_json_path, export_path)
	
	var reference_dict : = get_dictionary_from_file(reference_json_path)
	if reference_dict.has("error"):
		push_error(reference_dict.error)
		return
	
	for entry in reference_dict.classes:
		_update_links_db(entry, export_path)
	
#	print("PRINTING links_db: %s"%[JSON.print(links_db, "  ")])
	
	for entry in reference_dict.classes:
		_update_signatures_db(entry)
	
	for entry in reference_dict.classes:
		_build_and_save_md(entry, export_path)
	
	_build_and_save_sidebar(export_path)
	
	print("Success!")

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------
#---LINKS AND SIGNATURES --------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------

func _update_links_db(class_entry: Dictionary, export_path: String) -> void:
	var category: String = class_entry.category if class_entry.has("category") else ""
	var lowercase_name = class_entry.name.to_lower()
	
	var sanitized_category = ""
	if category.ends_with("/"):
		sanitized_category = category.rstrip("/").to_lower()
	else:
		sanitized_category = category.to_lower()
	
	if export_path.ends_with("/"):
			export_path = export_path.rstrip("/")
	
	var full_path = ""
	if sanitized_category == "":
		if export_path.get_file() == "content":
			full_path = lowercase_name
		else:
			full_path = "/%s/%s"%[export_path.get_file(), lowercase_name]
	else:
		if export_path.get_file() == "content":
			full_path = "/%s/%s"%[sanitized_category, lowercase_name]
		else:
			full_path = "/%s/%s/%s"%[export_path.get_file(),sanitized_category, lowercase_name]
	
	var objects: = _get_objects_for_links_db(class_entry)
	links_db[class_entry.name] = {
			local_path = lowercase_name,
			full_path = full_path,
			objects = objects,
	}


func _get_objects_for_links_db(class_entry: Dictionary) -> Array:
	var objects: = []
	for object in class_entry.sub_classes:
		objects.push_back(object.name)
	for object in class_entry.constants:
		objects.push_back(object.name)
	for object in class_entry.members:
		objects.push_back(object.name)
	for object in class_entry.signals:
		objects.push_back(object.name)
	for object in class_entry.methods:
		objects.push_back(object.name)
	for object in class_entry.static_functions:
		objects.push_back(object.name)
	return objects


func _update_signatures_db(class_entry: Dictionary) -> void:
	for object in class_entry.members:
		signatures_db[object.name] = _get_member_formatted_signature(object, class_entry)
	for object in class_entry.methods:
		signatures_db[object.name] = _get_method_formatted_signature(object, class_entry)


func _get_member_formatted_signature(member: Dictionary, class_entry: Dictionary) -> String:
	var type: = ""
	if member.data_type == "var":
		type = "[Variant]"
	else:
		type =  "[%s]"%[member.data_type]
	type = _check_for_links(type, class_entry.name)
	
	var doc_signature = "_%s_ **%s**"%[type, member.name]
	return doc_signature


func _get_method_formatted_signature(method: Dictionary, class_entry: Dictionary) -> Dictionary:
	var doc_signature: Dictionary = {
		full = "",
		partial = "" 
	}
	
	var return_type: = ""
	if method.return_type == "null":
		return_type = "void"
	elif method.return_type == "var":
		return_type = "[Variant]"
	else:
		return_type = "[%s]"%[method.return_type]
	return_type = _check_for_links(return_type, class_entry.name)
	
	var linked_name = _check_for_links("[%s]"%[method.name], class_entry.name)
	
	var argument_list: = ""
	for argument in method.arguments:
		var argument_type: = ""
		if argument.type == "var":
			argument_type = "Variant"
		else:
			argument_type = argument.type
		argument_type = _check_for_links("[%s]"%[argument_type], class_entry.name)
		argument_list += "%s"%[argument_type]
		argument_list += " %s"%[argument.name]
		argument_list += ", "
	argument_list = argument_list.left(argument_list.length()-", ".length())
	
	doc_signature.full = "_%s_ **%s**(%s)"%[return_type, method.name, argument_list]
	doc_signature.partial = "**%s**(%s)"%[linked_name, argument_list]
	return doc_signature

#--- LINKS AND SIGNATURES END ---------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------
#--- CONTENT, CATEGORIES, AND FILE WRITING --------------------------------------------------------
#--------------------------------------------------------------------------------------------------

func _build_and_save_md(docs_entry: Dictionary, export_path: String) -> void:
	var category: String = docs_entry.category if docs_entry.has("category") else ""
	_add_to_category_db(category, docs_entry.name, export_path)
	
	var md_filename: = "%s.md" % [docs_entry.name]
	var md_file_path: = _get_md_filepath(export_path, md_filename, category)
	
	var md_content: = _get_md_content(docs_entry)
	
	_write_documentation_file(md_content, md_file_path)


func _get_md_filepath(export_path: String, filename: String, category: = "") -> String:
	if not export_path.ends_with("/"):
		export_path += "/"
	
	if not category.ends_with("/") and category != "":
		category += "/"
	
	var filepath: = "%s%s%s"%[export_path, category, filename]
	return filepath


func _get_md_content(docs_entry: Dictionary) -> String:
	var md_content: = _get_inheritance_block(docs_entry)
	md_content += _get_description_block(docs_entry)
	
	if not docs_entry.members.empty() and not _get_properties_table(docs_entry) == "":
		md_content += MD_BLOCK_PROPERTIES_TABLE_TITLE
		md_content += _get_properties_table(docs_entry)
	
	if not docs_entry.methods.empty() and not _get_method_table(docs_entry) == "":
		md_content += MD_BLOCK_METHODS_TABLE_TITLE
		md_content += _get_method_table(docs_entry)
	
	if not docs_entry.signals.empty():
		md_content += _get_signals_block(docs_entry)
	
	if not docs_entry.constants.empty():
		md_content += _get_enums_and_constants_block(docs_entry)
	
	if not docs_entry.members.empty() and not _get_properties_block(docs_entry) == "":
		md_content += MD_BLOCK_PROPERTIES_DESCRIPTION
		md_content += _get_properties_block(docs_entry)
	
	if not docs_entry.methods.empty() and not _get_method_block(docs_entry) == "":
		md_content += MD_BLOCK_METHOD_DESCRIPTION
		md_content += _get_method_block(docs_entry)
	
	return md_content


func _add_to_category_db(category: String, page_title: String, export_path: String) -> Array:
	var base_dir_categories = []
	var category_db = _category_db.value
	if category == "":
		return base_dir_categories
	
	if not category.ends_with("/"):
		category += "/"
	
	if export_path.ends_with("/"):
			export_path = export_path.left(export_path.length()-1)
	
	base_dir_categories = _split_category_into_base_dirs(category)
	
	var previous_category: String = ""
	for base_dir in base_dir_categories:
		_create_category_entry_if_needed(base_dir)
		category_db[base_dir].full_path = "/%s/%s"%[export_path.get_file(), base_dir.to_lower()]
		
		if previous_category != "":
			if not category_db[base_dir].children.has(previous_category):
				category_db[base_dir].children.append(previous_category)
		
		previous_category = base_dir
	
	category_db[previous_category].is_root = true
	
	category = category.get_base_dir()
	if not category_db[category].page_titles.has(page_title):
		category_db[category].page_titles.append(page_title)
	
	return base_dir_categories


func _split_category_into_base_dirs(full_category: String) -> Array:
	var base_dirs: = []
	while (full_category.get_base_dir() != ""):
		var base_dir = full_category.get_base_dir()
		base_dirs.push_back(base_dir)
		full_category = base_dir
	
	return base_dirs


func _create_category_entry_if_needed(id: String) -> void:
	if not _category_db.value.has(id):
		_category_db.value[id] = {
			full_path = "",
			description = "",
			weight = "",
			is_root = false,
			children = [],
			page_titles = [],
		}
	
	if not _category_db.value[id].has("children"):
		_category_db.value[id]["children"] = []
	
	if _category_optional_data.value.has(id):
		_category_db.value[id].description = _category_optional_data.value[id].description
		_category_db.value[id].weight = _category_optional_data.value[id].weight
	else:
		var optional_data: CategoryOptionalData = CategoryOptionalData.new()
		optional_data.weight = _category_db.value[id].weight
		optional_data.description = _category_db.value[id].description
		
		_category_optional_data.value[id] = optional_data


func _write_documentation_file(p_content: String, p_file_path: String) -> void:
	var directory := Directory.new()
	if not directory.dir_exists(p_file_path.get_base_dir()):
		directory.make_dir_recursive(p_file_path.get_base_dir())
	
	var docs_file := File.new()
	var error = docs_file.open(p_file_path, File.WRITE)
	if error != OK:
		push_reading_file_error(error, p_file_path)
		return
	docs_file.store_string(p_content)
	docs_file.close()


func _build_and_save_sidebar(export_path: String) -> void:
	var md_filename = "_Sidebar.md"
	var md_file_path =  _get_md_filepath(export_path, md_filename)
	
	var sidebar_content: = _get_export_full_toc_dict()
	
	var md_content = _sidebar_prepend.value
	md_content += _get_toc(sidebar_content)
	
	_write_documentation_file(md_content, md_file_path)


func _get_export_full_toc_dict() -> Dictionary:
	var sidebar_content: = {
		page_titles = [],
		children = []
	}
	
	var root_pages = links_db.keys()
	for key in _category_db.value.keys():
		var pages: Array = _category_db.value[key].page_titles
		
		for page in pages:
			if root_pages.has(page):
				root_pages.erase(page)
		
		if _category_db.value[key].is_root:
			sidebar_content.children.append(key)
	
	sidebar_content.page_titles = root_pages
	
	return sidebar_content


func _get_toc(starting_category: Dictionary, identation = "") -> String:
	var content = ""
	content += _get_link_tree(starting_category, identation)
	
	if starting_category.has("children") and not starting_category.children.empty():
		for category_name in starting_category.children:
			var category: Dictionary = _category_db.value[category_name]
			content += "%s- **%s**  \n"%[identation, category_name.get_file()]
			content += _get_toc(category, identation + "  ")
	
	return content


func _get_link_tree(dict : Dictionary, identation: = "") -> String:
	var link_tree: = ""
	
	if dict.has("page_titles"):
		for page in dict.page_titles:
			link_tree += "%s [%s](%s)  \n"%[identation, page, page]
	
	return link_tree

#--- CONTENT, CATEGORIES, AND FILE WRITING END ----------------------------------------------------

#--------------------------------------------------------------------------------------------------
#--- INNER MD BLOCKS ------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------

#------ INHERITANCE -------------------------------------------------------------------------------

func _get_inheritance_block(docs_entry: Dictionary) -> String:
	var content: = ""
	
	var inheritance_string: = _format_array_into_string(
			docs_entry.extends_class, " > ", docs_entry.name)
	
	content += MD_BLOCK_INHERITANCE.format({
				inheritance=inheritance_string, 
		})
		
	if docs_entry.has("inherited_by"):
		var inherited_by_string = _format_array_into_string(
				docs_entry.inherited_by, ", ", docs_entry.name)
		
		content += MD_BLOCK_INHERITED_BY.format({
				inherited_by=inherited_by_string
		})
	
	return content


func _format_array_into_string(p_array: Array, delimiter: String, p_class_name: String) -> String:
	var formatted_string: = ""
	for entry in p_array:
		var keyword = "[%s]"%[entry]
		var treated_text = _check_for_links(keyword, p_class_name)
		formatted_string += "%s%s"%[treated_text, delimiter]
	
	formatted_string = formatted_string.left(formatted_string.length()-delimiter.length())
	return formatted_string

#------ INHERITANCE END ---------------------------------------------------------------------------

#------ DESCRIPTION AND LINKS ---------------------------------------------------------------------

func _get_description_block(docs_entry: Dictionary) -> String:
	var text = MD_BLOCK_DESCRIPTION.format({description=docs_entry.description})
	text = _check_for_links(text, docs_entry.name)
	
	return text


func _check_for_links(text: String, p_class_name: String) -> String:
	if not text.match("*[*]*"):
		return text
	
	var search_index = 0
	while search_index > -1:
		var start_index = text.find("[", search_index)
		var end_index = text.find("]", start_index)
		if start_index == -1 or end_index == -1 or end_index < start_index:
			search_index = -1
			break
		
		search_index = end_index
		
		if text.substr(end_index+1, 1) == "(":
			continue
		
		var keyword = _get_link_keyword(text, start_index + 1, end_index)
		var nested_link = _get_nested_link(keyword)
		
		text = _handle_links_in_text(text, end_index + 1, keyword, nested_link, p_class_name)
	
	return text 


func _get_link_keyword(text: String, start_index: int, end_index: int) -> String:
	var length = end_index - start_index
	var keyword = text.substr(start_index, length)
	return keyword


func _get_nested_link(keyword: String) -> Array:
	var nested_link = []
	if keyword.find("."):
		nested_link = keyword.split(".")
	return nested_link


func _add_link_to_keyword(text: String, split_index: int, link: String) -> String:
	var left = text.left(split_index)
	var right = text.right(split_index)
	text = "%s(%s)%s"%[left, link, right]
	return text


func _add_external_link_to_keyword(text: String, split_index: int, link: String) -> String:
	var left = text.left(split_index)
	var right = text.right(split_index)
	text = "%s(%s)%s"%[left, link, right]
	return text


func _add_link_to_keyword_section(text: String, split_index: int, 
		link: String, hash_link: String, keyword: String = "") -> String:
	var left = text.left(split_index)
	var right = text.right(split_index)
	
	if keyword != "":
		left = left.replace(keyword, hash_link)
	
	text = "%s(%s#%s)%s"%[left, link, hash_link, right]
	return text


func _handle_links_in_text(text: String, split_index: int, 
		keyword: String, nested_link: Array, page_name: String) -> String:
	if ClassDB.class_exists(keyword) or _built_in_type_db.value.has(keyword):
		var link = GODOT_DOCS_BASE_URL%[keyword.to_lower()]
		text = _add_external_link_to_keyword(text, split_index, link)
	elif links_db.has(keyword):
		text = _add_link_to_keyword(text, split_index, links_db[keyword][key_to_use_for_link])
	elif not nested_link.empty() and links_db.has(nested_link[0]):
		text = _add_link_to_keyword_section(
				text, 
				split_index, 
				links_db[nested_link[0]][key_to_use_for_link], 
				nested_link[1], 
				keyword
		)
	elif links_db.has(page_name) and links_db[page_name].objects.has(keyword):
		text = _add_link_to_keyword_section(
				text, 
				split_index, 
				links_db[page_name][key_to_use_for_link], 
				keyword
		)
	else:
		push_warning("Unable to find link for %s in %s script"%[keyword, page_name])
	
	return text

#------ DESCRIPTION AND LINKS END -----------------------------------------------------------------

#------ CONTENT TABLES ----------------------------------------------------------------------------

func _get_properties_table(docs_entry: Dictionary) -> String:
	var table = ""
	for member in docs_entry.members:
		if member.name.begins_with("_"):
			continue
		
		var type = "[%s]"%[member.data_type]
		if type == "[var]":
			type = "[Variant]"
		type = _check_for_links(type, docs_entry.name)
	
		var property_name = _check_for_links("[%s]"%[member.name], docs_entry.name)
		var default_value = member.default_value
		if typeof(default_value) == TYPE_STRING:
			default_value = "\"%s\""%[default_value]
		default_value = "`%s`"%[default_value]
	
		table += MD_BLOCK_PROPERTIES_TABLE_LINE.format({
			type = type,
			name = property_name,
			default_value = default_value,
		})
		
	return table


func _get_method_table(docs_entry: Dictionary) -> String:
	var table = ""
	for method in docs_entry.methods:
		if method.name.begins_with("_"):
			continue
		
		var type = "[%s]"%[method.return_type]
		if type == "[var]":
			type = "[Variant]"
		type = _check_for_links(type, docs_entry.name)
	
		var property_name = ""
		if signatures_db.has(method.name):
			property_name = signatures_db[method.name].partial
		else:
			property_name = _check_for_links("[%s]"%[method.name], docs_entry.name)
		
		table += MD_BLOCK_METHOD_TABLE_LINE.format({
			type = type,
			siganture = property_name,
		})
		
	return table

#------ CONTENT TABLES END ------------------------------------------------------------------------

#------ CONTENT LISTS -----------------------------------------------------------------------------

func _get_signals_block(docs_entry: Dictionary) -> String:
	var block = MD_BLOCK_SIGNALS_TITLE
	for entry in docs_entry.signals:
		var description = _check_for_links(entry.description, docs_entry.name)
		block += MD_BLOCK_SIGNALS_LINE.format({
			name = entry.name,
			arguments = str(entry.arguments).replace("[", "").replace("]", ""),
			description = description,
		})
	return block


func _get_enums_and_constants_block(docs_entry: Dictionary) -> String:
	var block: = ""
	var block_enums: = ""
	var block_constants: = ""
	for constant in docs_entry.constants:
		if _is_enum(constant):
			if block_enums == "":
				block_enums = MD_BLOCK_ENUMS_TITLE
			block_enums += MD_BLOCK_ENUM_NAME_LINE.format({name = constant.name})
			for key in constant.value.keys():
				block_enums += MD_BLOCK_ENUM_KEY_LINE.format({
					signature = "%s = %s"%[key, constant.value[key]],
				})
			
			block_enums += "---------\n"
		else:
			if block_constants == "":
				block_constants = MD_BLOCK_CONSTANTS_TITLE
			
			if constant.description != "":
				block_constants += MD_BLOCK_CONSTANTS_LINE.format({
					signature = "%s = %s"%[constant.name, constant.value],
					description = constant.description.strip_edges()
				})
			else:
				block_constants += MD_BLOCK_ENUM_KEY_LINE.format({
					signature = "%s = %s"%[constant.name, constant.value],
				})
	
	block = block_enums + block_constants
	
	return block


func _is_enum(constant_dict: Dictionary) -> bool:
	var is_enum: = true
	if constant_dict.data_type == "Dictionary":
		for value in constant_dict.value.values():
			if typeof(value) != TYPE_INT and typeof(value) != TYPE_REAL:
				is_enum = false
				break
	else:
		is_enum = false
	
	return is_enum

#------ CONTENT LISTS END -------------------------------------------------------------------------

#------ DETAILED DOCS -----------------------------------------------------------------------------

func _get_properties_block(docs_entry: Dictionary) -> String:
	var content: = ""
	if not docs_entry.members.empty():
		for property in docs_entry.members:
			if property.name.begins_with("_"):
				continue
			
			var property_signature = ""
			if signatures_db.has(property.name):
				property_signature = signatures_db[property.name]
			
			var table = _get_property_details_table(property)
			
			content += MD_BLOCK_PROPERTY.format({
				name = property.name,
				property_signature = property_signature,
				table = table,
				description = property.description,
			})
	
	return content


func _get_property_details_table(property: Dictionary) -> String:
	var table = "<table><tbody>  \n"
	
	if property.default_value != null:
		table += "<tr> <th>_Default_</th> <th>`%s`</th> </tr>  \n"%[property.default_value]
	
	if property.setter != "":
		table += "<tr> <th>_Setter_</th> <th>%s</th> </tr>  \n"%[property.setter]
	
	if property.getter != "":
		table += "<tr> <th>_Getter_</th> <th>%s</th> </tr>  \n"%[property.getter]
	
	table += "</tbody></table>"
	
	if table == "<table><tbody>  \n</tbody></table>":
		table = ""
	
	return table


func _get_method_block(docs_entry: Dictionary) -> String:
	var content = ""
	
	if not docs_entry.methods.empty():
		for method in docs_entry.methods:
			if method.name.begins_with("_"):
				continue
			
			var method_signature = ""
			if signatures_db.has(method.name):
				method_signature = signatures_db[method.name].full
			
			content += MD_BLOCK_METHOD.format({
				name = method.name,
				method_signature = method_signature,
				description = method.description,
			})
	
	return content

#------ DETAILED DOCS END -------------------------------------------------------------------------

#--- INNER MD BLOCKS END --------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------
