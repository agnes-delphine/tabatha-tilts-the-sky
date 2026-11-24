extends Node
class_name BaseBossMove

## Should this move be used at all?
@export var enabled := true

## The ID of the move.
@export var move_id := &"BaseBossMoveID"

## How heavily weighted this move is to be used.
## Higher weight means higher odds. (0.0 = Never)
@export var move_weight := 1.0

@export_category("Move Statistics")
## The minimum duration (in seconds) the boss will pause for after using this attack.
@export var min_delay := 1.0
## The maximum duration (in seconds) the boss will pause for after using this attack.
@export var max_delay := 3.0
## Should this move be executed more than once in a row?
@export var repeatable := false

## The boss using this move.
var boss : Boss

## Used by a lot of moves, so here to prevent repetition.
var tween : Tween

## Emitted when the boss does not meet the requirements to use the move.
## Causes the moveset controller to immediately pick a new one.
@warning_ignore("unused_signal")
signal InvalidMove()

func _ready() -> void:
	BossManager.boss_registered.connect(_on_boss_registered)

func _on_boss_registered(_boss: Boss) -> void:
	boss = _boss

## What actually happens when the move is executed.
func execute() -> void:
	pass

## This should return true if the move can be used at this current point in time.
func is_valid() -> bool:
	return true
