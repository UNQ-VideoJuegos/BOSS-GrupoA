extends KinematicBody2D

export var speed = 250
export var chaser_damage = 25
export var life = 50

var target = null
var velocity= Vector2.ZERO
var dir_to_target = Vector2.ZERO

func _ready():
	$AnimatedSprite.hide()

func _process(delta):
	if target != null:
		var chase = target.global_position
		velocity = position.direction_to(chase) * speed
		if position.distance_to(target.global_position) < 10:
			_boom_damage()
	else:
		velocity = Vector2.ZERO
	velocity = move_and_slide(velocity)
	if life <= 0:
		boom()


func boom():
	speed = 0
	$AnimatedSprite.show()
	$AnimatedSprite.play()
	yield(get_tree().create_timer(0.5), "timeout")
	queue_free()


func _boom_damage():
	if target != null:
		speed = 0
		$AnimatedSprite.show()
		$AnimatedSprite.play()
		target.damage(chaser_damage)
		yield(get_tree().create_timer(0.5), "timeout")
		queue_free()


func _on_Detection_area_body_entered(body):
	if body.name == "Player":
		target = body


func _on_Hitbox_area_entered(area):
	if area.name == "Bullet":
		$Sprite.modulate = Color.red # solo de prueba, no es final
		life -= area.damage
		yield(get_tree().create_timer(2.0),"timeout")
		$Sprite.modulate = Color.white
