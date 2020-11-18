extends Node2D

func _ready():
	
	Global.actual_scene = "res://scenes/levels/Level3.tscn"
	
	$doors/Interruptor.connect("triggered", $doors/Door1, "_on_Interruptor_triggered") 
