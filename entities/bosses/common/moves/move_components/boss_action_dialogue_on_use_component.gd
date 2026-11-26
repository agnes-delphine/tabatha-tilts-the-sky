extends BaseBossActionComponent
class_name BossActionDialogueOnUseComponent

@export var dialogue : DialogueResource

func execute() -> void:
	DialogueManager.show_dialogue_balloon(dialogue)
