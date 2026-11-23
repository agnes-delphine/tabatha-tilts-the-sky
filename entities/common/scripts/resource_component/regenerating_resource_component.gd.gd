extends ResourceComponent
class_name RegeneratingResourceComponent

## How long between each increase?
@export var charge_interval := 0.5

## Increase by how much?
@export var increase_rate := 10.0

func _ready() -> void:
	super()
	
	var timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_on_timeout)
	timer.start(charge_interval)

func _on_timeout() -> void:
	increase(increase_rate)
