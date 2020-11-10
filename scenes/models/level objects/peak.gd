extends Area2D

export var damage = 30

func _on_peak_body_entered(body):
	if body.name == "Player":
		body.damage(damage)
	elif body.is_in_group("plataform"):
		body.destroy()
