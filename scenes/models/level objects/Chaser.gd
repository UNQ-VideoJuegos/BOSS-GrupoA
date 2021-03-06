extends KinematicBody2D

export var speed = 250
export var chaser_damage = 25
export var max_health = 50

var target = null
var velocity= Vector2.ZERO
var dir_to_target = Vector2.ZERO

func _ready():
	$AnimatedBoom.hide()
	$AnimatedSprite.play("default")

func _process(delta):
	if target != null:
		var chase = target.global_position
		velocity = position.direction_to(chase) * speed
		if position.distance_to(target.global_position) < 10:
			_boom_damage()
		$AnimatedSprite.flip_h = position.direction_to(chase).x < 0
	else:
		velocity = Vector2.ZERO
	velocity = move_and_slide(velocity)
	if max_health <= 0:
		boom()


func boom():
	speed = 0
	$AnimatedBoom.show()
	$AnimatedBoom.play()
	yield(get_tree().create_timer(0.5), "timeout")
	queue_free()


func _boom_damage():
	if target != null:
		speed = 0
		$AnimatedSprite.hide()
		$AnimatedBoom.show()
		$AnimatedBoom.play()
		target.damage(chaser_damage)
		yield(get_tree().create_timer(0.5), "timeout")
		queue_free()


func _on_Detection_area_body_entered(body):
	if body.name == "Player":
		target = body
		$Timer.start()


func _on_Hitbox_area_entered(area):
	if area.name == "Bullet":
		$AnimatedSprite.modulate = Color.red # solo de prueba, no es final
		max_health -= area.damage
		$HealthDisplay.update_healthbar(max_health)
		yield(get_tree().create_timer(0.3),"timeout")
		$AnimatedSprite.modulate = Color.white


func _on_Timer_timeout():
	boom()
