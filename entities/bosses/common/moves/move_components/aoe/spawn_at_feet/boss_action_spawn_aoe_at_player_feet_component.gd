extends BaseBossActionComponent
class_name BossActionSpawnAOEAtPlayerFeetComponent

@onready var aoe_component: BossActionAOEDamageComponent = $BossActionAOEDamageComponent
@onready var targets_player: BossActionTargetsPlayerComponent = $BossActionTargetsPlayerComponent

@export var repeat_count := 1
@export var repeat_delay := 0.2

func execute() -> void:
	
	for i in repeat_count:
		var aoe = aoe_component.get_aoe()
		aoe.global_position = targets_player.get_player_pos()
		await get_tree().create_timer(repeat_delay).timeout
