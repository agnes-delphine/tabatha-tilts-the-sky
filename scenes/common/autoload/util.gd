extends Node
class_name util

static func get_direct_children_of_type(parent: Node, type: Variant) -> Array[Node]:
	var result: Array[Node] = []
	for child in parent.get_children():
		if is_instance_of(child, type):
			result.append(child)
	return result
