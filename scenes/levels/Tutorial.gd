extends Node2D

func _ready():
	Global.actual_scene = "res://scenes/levels/Tutorial.tscn"
	
	$interruptores/Interruptor.connect("triggered", $puertas/Door, "_on_Interruptor_triggered") 
	$interruptores/Interruptor2.connect("triggered", $puertas/Door2, "_on_Interruptor_triggered") 
