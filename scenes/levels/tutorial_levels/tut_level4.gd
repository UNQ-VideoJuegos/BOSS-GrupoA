extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Interruptor.connect("triggered", $Door, "_on_Interruptor_triggered")
	Global.actual_scene = "res://scenes/levels/tutorial_levels/tut_level4.tscn"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
