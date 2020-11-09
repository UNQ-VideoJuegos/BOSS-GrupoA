extends Area2D

export var speed = 100

var target = null
var velocity= Vector2.ZERO
var dir_to_target = Vector2.ZERO

func _physics_process(delta):
	if target != null:
		dir_to_target = (target.global_position - global_position).normalized()
	
	position += dir_to_target * speed * delta


func _on_Chaser_body_entered(body):
	if body.name == "Player":
		target = body


func _on_Chaser_area_entered(area):
	$Sprite.modulate = Color.red # solo de prueba, no es final
	yield(get_tree().create_timer(0.2),"timeout")
	$Sprite.modulate = Color.white
