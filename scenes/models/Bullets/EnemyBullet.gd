extends Area2D

export (int) var speed = 250
export (float) var lifetime = 1.0
export (int) var damage = 10

var velocity = Vector2()

func start(pos,dir):
	position = pos
	rotation = dir.angle()
	
	velocity = speed * dir

func _process(delta):
	position += velocity * delta

func _on_Bullet_body_entered(body):
	if body.name == "Player":
		body.damage(damage)
	queue_free()

func _on_Bullet_area_entered(area):
	queue_free()

func _on_LifeTimer_timeout():
	queue_free()
