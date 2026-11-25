extends Node
class_name BossPhaseControllerComponent

var current_phase : BaseBossPhase

signal phase_changed(new_phase: BaseBossPhase)

func set_phase(new_phase: BaseBossPhase) -> void:
	if is_instance_valid(current_phase):
		current_phase.phase_exited()
	
	new_phase.phase_entered()
	current_phase = new_phase
	
	phase_changed.emit(new_phase)
	
	Log.prn("-- Phase set to %s --" % new_phase)
