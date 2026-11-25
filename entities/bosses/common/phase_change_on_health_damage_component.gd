extends Node
class_name PhaseChangeOnHealthDamageComponent

## When this much health is remaining, go to that phase.
@export var health_to_phase : Dictionary[float, BaseBossPhase]

@onready var boss_health_component: BossHealthComponent = %BossHealthComponent
@onready var boss_phase_controller_component: BossPhaseControllerComponent = %BossPhaseControllerComponent

func _ready() -> void:
	boss_health_component.resource_changed.connect(_on_health_changed)

func _on_health_changed(update: ResourceUpdate) -> void:
	var health = update.current_value
	
	var new_phase = health_to_phase.get(health)
	if !is_instance_valid(new_phase):
		return
	
	boss_phase_controller_component.set_phase(new_phase)
