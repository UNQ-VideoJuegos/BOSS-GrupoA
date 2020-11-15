extends "res://Scripts/StateMachine.gd"


func _ready():
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("fall")
	call_deferred("set_state", states.idle)


func _state_logic(delta): # metodo que maneja la logica (handler)
	pass

func _get_transition(delta): # maneja las transiciones
	pass

func _enter_state(new_state, old_state): # metodo para setear animaciones o timers
	pass

func _exit_state(old_state,new_state):
	pass
