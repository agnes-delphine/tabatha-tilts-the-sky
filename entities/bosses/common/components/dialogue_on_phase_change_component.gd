extends Node
class_name DialogueOnPhaseChangeComponent

@onready var boss_phase_controller: BossPhaseControllerComponent = %BossPhaseControllerComponent

@export var phase_to_dialogue : Dictionary[BaseBossPhase, DialogueResource]

func _ready() -> void:
	boss_phase_controller.phase_changed.connect(_on_phase_changed)

func _on_phase_changed(new_phase: BaseBossPhase) -> void:
	var dialogue = phase_to_dialogue.get(new_phase)
	if !is_instance_valid(dialogue):
		return
	
	DialogueManager.show_dialogue_balloon(dialogue)
