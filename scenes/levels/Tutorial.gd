extends Node2D

func _ready():
	Global.actual_scene = "res://scenes/levels/Tutorial.tscn"
	
	$Interruptor2.connect("triggered", $Door, "_on_Interruptor_triggered") 
	$Interruptor.connect("triggered", $Door2, "_on_Interruptor_triggered") 
