extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Interruptor.connect("triggered", $Door, "_on_Interruptor_triggered") 

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused == true:
			get_tree().paused = false
		else:
			get_tree().paused = true
