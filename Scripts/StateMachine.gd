extends Node

# abstract state machine

class_name StateMachine

var state = null setget set_state
var previous_state = null

var states = {}

onready var parent = get_parent() # referencia de quien va a estar controlando


func _physics_process(delta):
	if state != null:
		_state_logic(delta)
		var trasition = _get_transition(delta)
		if trasition != null:
			set_state(trasition)


func _state_logic(delta): # metodo que maneja la logica (handler)
	pass

func _get_transition(delta): # maneja las transiciones
	pass

func _enter_state(new_state, old_state): # metodo para setear animaciones o timers
	pass

func _exit_state(old_state,new_state):
	pass

func set_state(new_state): # para cambiar de estados 
	previous_state = state
	state = new_state
	
	if previous_state != null:
		_exit_state(previous_state,new_state)
	if new_state != null:
		_enter_state(new_state,previous_state)


func add_state(state_name):
	states[state_name] = states.size()
