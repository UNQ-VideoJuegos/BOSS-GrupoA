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
			elif parent.velocity.x == 0:
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
			if parent.right_orientation:
				parent.anim.play("idle-right")
				parent.anim.advance(0)
			else:
				parent.anim.play("idle-left")
				parent.anim.advance(0)
		states.run:
			if parent.right_orientation:
				parent.anim.play("run-right")
				parent.anim.advance(0)
			else:
				parent.anim.play("run-left")
				parent.anim.advance(0)
		states.jump:
			if parent.right_orientation:
				parent.anim.play("jump-right")
				parent.anim.advance(0)
			else:
				parent.anim.play("jump-left")
				parent.anim.advance(0)
		states.fall:
			if parent.right_orientation:
				parent.anim.play("fall-right")
				parent.anim.advance(0)
			else:
				parent.anim.play("fall-left")
				parent.anim.advance(0)
		states.death:
			if parent.right_orientation:
				parent.anim.play("death-right")
				parent.anim.advance(0)
			else:
				parent.anim.play("death-left")
				parent.anim.advance(0)


func _on_Player_health_updated(health):
	parent.animation.play("hit")
	yield(get_tree().create_timer(0.8),"timeout")
	parent.animation.play("idle")
	
