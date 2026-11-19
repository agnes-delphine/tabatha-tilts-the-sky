extends Node

var current_arena : BaseArena
signal arena_registered(arena: BaseArena)

func register_arena(arena: BaseArena) -> void:
	current_arena = arena
	arena_registered.emit(arena)

func clear_arena() -> void:
	current_arena = null
