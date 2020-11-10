extends Sprite

func _ready():
#	$AlphaTween.interpolate_property(self,"modulate",Color(1,1,1,1),Color(1,1,1,0),0.6,Tween.TRANS_LINEAR,Tween.EASE_OUT)
#	$AlphaTween.start()
	pass

func _physics_process(delta):
	modulate.a = lerp(modulate.a,0,0.1)
	if modulate.a < 0.01:
		queue_free()
	

func _on_AlphaTween_tween_completed(object, key):
	queue_free()
	
