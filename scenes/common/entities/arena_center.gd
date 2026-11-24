extends Marker3D
class_name ArenaCenter

func _ready() -> void:
	ArenaManager.arena_center = self
