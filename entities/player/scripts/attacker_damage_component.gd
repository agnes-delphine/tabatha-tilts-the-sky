extends Node
class_name AttackerDamageComponent

@onready var attacker: AttackerComponent = %AttackerComponent
@onready var attacker_charge: AttackerChargeComponent = %AttackerChargeComponent

func _ready() -> void:
	attacker.player_attacked.connect(_on_attack)
