extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.actual_scene = "res://scenes/levels/Level2.tscn"
	$Interruptor.connect("triggered", $Door, "_on_Interruptor_triggered") 

