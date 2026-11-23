extends Node

## Neatly tweens the current value of the progress bar
## to another given value.
## Returns the tween created.
func tween_bar(
	bar: ProgressBar, 
	new_value: float, 
	tween_duration := 0.5,
	transition_type := Tween.TransitionType.TRANS_LINEAR,
	ease_type := Tween.EaseType.EASE_IN_OUT
	) -> Tween:
		
	var tween := get_tree().create_tween()
	tween.set_ease(ease_type)
	tween.set_trans(transition_type)
	tween.tween_property(bar, "value", new_value, tween_duration)
	
	return tween
