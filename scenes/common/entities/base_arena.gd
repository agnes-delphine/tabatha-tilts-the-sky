extends Node3D
class_name BaseArena

var arena_center: ArenaCenter

func _ready() -> void:
	var center : ArenaCenter = util.get_direct_children_of_type(self, ArenaCenter).front()
	if !is_instance_valid(center):
		push_error("No valid center set for arena!")
		return
	
	arena_center = center
	ArenaManager.register_arena(self)
