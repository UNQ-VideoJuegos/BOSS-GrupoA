extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.actual_scene = "res://scenes/levels/Level1.tscn"
	
	$Interruptor2.connect("triggered", $Door, "_on_Interruptor_triggered")
	$Interruptor3.connect("triggered", $Door2, "_on_Interruptor_triggered")
	$Interruptor.connect("triggered", $Interruptor3, "_on_Interruptor_triggered") 

