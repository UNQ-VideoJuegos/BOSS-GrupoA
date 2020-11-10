extends KinematicBody2D

export var speed = 100

var target = null
var velocity= Vector2.ZERO
var dir_to_target = Vector2.ZERO

func _process(delta):
	if target != null:
		var chase = target.global_position
		velocity = position.direction_to(chase) * speed
	else:
		velocity = Vector2.ZERO
	velocity = move_and_slide(velocity)
	


func _on_Detection_area_body_entered(body):
	if body.name == "Player":
		target = body


func _on_Hitbox_area_entered(area):
	if area.name == "Bullet":
		var chaser = target
		$Sprite.modulate = Color.red # solo de prueba, no es final
		target = null
		yield(get_tree().create_timer(2.0),"timeout")
		$Sprite.modulate = Color.white
		target = chaser
