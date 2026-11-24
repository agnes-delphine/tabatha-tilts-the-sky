extends Node
class_name BossMovesetController

signal move_started(move: BaseBossMove)
signal move_finished(move: BaseBossMove)

var _rng := RandomNumberGenerator.new()
var _moves: Array[BaseBossMove] = []
var _weights := PackedFloat32Array()

var _acting := false

var _last_move: BaseBossMove = null

@export var global_delay_multiplier := 1.0

func _ready() -> void:
	await get_tree().create_timer(1).timeout ## Delay to prevent races during testing.
	_rng.randomize()
	_collect_moves()
	start()

func _collect_moves() -> void:
	for child in get_children():
		if child is BaseBossMove:
			_moves.append(child)
			_weights.append(child.move_weight)

func start() -> void:
	if _acting:
		return
	_acting = true
	_run_loop()

func stop() -> void:
	_acting = false

func _run_loop() -> void:
	if _moves.is_empty():
		push_error("BossMovesetController has no moves to execute.")
		_acting = false
		return
	
	while _acting:
		var move := _pick_move()
		if move == null:
			await get_tree().process_frame
			continue
		await _execute(move)

func _pick_move() -> BaseBossMove:
	var valid_weights := PackedFloat32Array()
	var total := 0.0
	for i in _moves.size():
		var weight := _weights[i] if _moves[i].is_valid() else 0.0
		valid_weights.append(weight)
		total += weight
	if total <= 0.0:
		return null
	
	if _last_move != null and !_last_move.repeatable:
		var last_index := _moves.find(_last_move)
		if last_index != -1:
			var weight_without_last := total - valid_weights[last_index]
			if weight_without_last > 0.0:
				valid_weights[last_index] = 0.0
	
	var picked := _moves[_rng.rand_weighted(valid_weights)]
	_last_move = picked
	return picked

func _execute(move: BaseBossMove) -> void:
	if !move.is_valid():
		await get_tree().process_frame
		return
	
	print("Executing %s" % move.move_id)
	move.execute()
	move_started.emit(move)
	await get_tree().create_timer(_rng.randf_range(move.min_delay, move.max_delay) * global_delay_multiplier).timeout
	move_finished.emit(move)
