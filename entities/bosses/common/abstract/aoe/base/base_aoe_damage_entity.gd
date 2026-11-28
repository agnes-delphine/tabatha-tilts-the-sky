extends Node3D
class_name BaseAOEDamageEntity

@onready var lifetime_timer: Timer = %LifetimeTimer
@onready var delay_timer: Timer = %DelayTimer
@onready var hitbox: Hitbox = %Hitbox

@onready var inactive: Node3D = %Inactive
@onready var active: Node3D = %Active

var delay : float
var lifetime : float
var damage : DamageInstance

func _ready() -> void:
	delay_timer.timeout.connect(activate)
	lifetime_timer.timeout.connect(deactivate)

func execute() -> void:
	hitbox.set_collider_state(false)
	delay_timer.start(delay)

func activate() -> void:
	hitbox.set_collider_state(true)
	lifetime_timer.start()
	hitbox.damage_instance = damage
	
	inactive.hide()
	active.show()

func deactivate() -> void:
	queue_free()
