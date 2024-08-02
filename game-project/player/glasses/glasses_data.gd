class_name GlassesData extends Resource

var index := 0
var elements : Array[GlassesTypeData] = []

signal index_changed(new_index:int)
signal elements_changed(new_elements:Array[GlassesTypeData])

func count() -> int:
	return elements.size()

func get_current_glasses() -> GlassesTypeData:
	return elements[index]

func pick_relative(delta:int) -> void:
	var new_index : int = (index + delta + count()) % count()
	set_index(new_index)

func pick_absolute(abs_index:int) -> void:
	var new_index : int = abs_index % count()
	set_index(new_index)

func set_index(idx:int) -> void:
	index = idx
	index_changed.emit(index)

func add_element(e:GlassesTypeData) -> void:
	elements.append(e)
	on_elements_changed()

func remove_element(e:GlassesTypeData) -> void:
	elements.erase(e)
	on_elements_changed()

func on_elements_changed() -> void:
	elements_changed.emit(elements)
