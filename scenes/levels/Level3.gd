extends Node2D

func _ready():
	
	Global.actual_scene = "res://scenes/levels/Level3.tscn"
	
	$doors/Interruptor.connect("triggered", $doors/Door1, "_on_Interruptor_triggered") 
	$doors/Interruptor2.connect("triggered", $doors/Door6, "_on_Interruptor_triggered")
	$doors/Interruptor3.connect("triggered", $doors/DoorFinal, "_on_Interruptor_triggered") 
