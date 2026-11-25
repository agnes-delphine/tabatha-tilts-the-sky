extends Node
class_name BossMovesetControllerComponent

@onready var boss_phase_controller: BossPhaseControllerComponent = $"../Components/BossPhaseControllerComponent"

@export var global_delay_multiplier := 1.0

var _rng := RandomNumberGenerator.new()

var _acting := false
var _last_move: BaseBossMove = null

var _phases : Dictionary[BaseBossPhase, Dictionary]

signal move_started(move: BaseBossMove)
signal move_finished(move: BaseBossMove)

func _ready() -> void:
	boss_phase_controller.phase_changed.connect(_on_phase_changed)
	await get_tree().process_frame
	_rng.randomize()
	_collect_moves()
	if !_phases.is_empty():
		boss_phase_controller.set_phase(_phases.keys()[0])
	start()

func _collect_moves() -> void:
	for child in get_children():
		var moves : Dictionary[BaseBossMove, float]
		if child is not BaseBossPhase:
			continue
		
		for grandchild in child.get_children():
			if grandchild is not BaseBossMove:
				continue
			
			moves[grandchild as BaseBossMove] = grandchild.move_weight
		
		_phases[child as BaseBossPhase] = moves

func start() -> void:
	if _acting:
		return
	_acting = true
	_run_loop()

func stop() -> void:
	_acting = false

func _run_loop() -> void:
	if !is_instance_valid(boss_phase_controller.current_phase):
		push_error("BossMovesetController ran into an invalid phase!")
		_acting = false
		return
	
	if _phases.is_empty():
		push_error("BossMovesetController has no phases to execute!")
		_acting = false
		return
	
	while _acting:
		var move := _pick_move()
		if move == null:
			await get_tree().process_frame
			continue
		await _execute(move)

func _pick_move() -> BaseBossMove:
	var moves := _phases[boss_phase_controller.current_phase]
	var valid_weights := PackedFloat32Array()
	var total := 0.0
	for move in moves:
		var weight = moves[move] if move.is_valid() and move.enabled else 0.0
		valid_weights.append(weight)
		total += weight
	if total <= 0.0:
		return null
	
	if is_instance_valid(_last_move) and !_last_move.repeatable:
		var last_index = moves[_last_move]
		if last_index != -1:
			var weight_without_last := total - valid_weights[last_index]
			if weight_without_last > 0.0:
				valid_weights[last_index] = 0.0
	
	## If this is a chain move, get the next.
	if _last_move != null and is_instance_valid(_last_move.next_move):
		_last_move = _last_move.next_move
		return _last_move
	
	var picked = moves.keys()[_rng.rand_weighted(valid_weights)]
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

##

func _on_phase_changed(_phase: BaseBossPhase) -> void:
	_last_move = null
