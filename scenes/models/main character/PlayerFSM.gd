extends "res://Scripts/StateMachine.gd"


func _ready():
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("fall")
	add_state("death")
	call_deferred("set_state", states.idle)


func _state_logic(delta): # metodo que maneja la logica (handler)
	parent._apply_gravity(delta)
	parent._move_input()
	parent._jump()
	parent._shoot()
	parent._dash()
	parent._apply_movement()

func _get_transition(delta): # maneja las transiciones
	match state:
		states.idle:
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.velocity.x != 0:
				return states.run
			elif parent.health <= 0 or parent.is_dead:
				return states.death
		states.run:
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.move_direction == 0:
				return states.idle
			elif parent.health <= 0 or parent.is_dead:
				return states.death
		states.jump:
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y >= 0:
				return states.fall
			elif parent.health <= 0 or parent.is_dead:
				return states.death
		states.fall:
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y < 0:
				return states.jump
			elif parent.health <= 0 or parent.is_dead:
					return states.death
	return null

func _enter_state(new_state, old_state): # metodo para setear animaciones o timers
	match new_state:
		states.idle:
			parent.animation.play("idle")
		states.run:
			parent.animation.play("run")
		states.jump:
			parent.animation.play("jump")
		states.fall:
			parent.animation.play("fall")
		states.death:
			parent.animation.play("death")


func _on_Player_health_updated(health):
	parent.animation.play("hit")
	yield(get_tree().create_timer(0.8),"timeout")
	parent.animation.play("idle")
	
