extends KinematicBody2D

var hideTrap = false

func _ready():
	add_to_group("plataform")	
	$PlatformTrapTimer.start()

func destroy():
	queue_free()
	
func hideTrap():
	$trap.hide()
	$trap2.hide()
	$trap.disableDamage()
	$trap2.disableDamage()
	
func showTrap():
	$trap.show()
	$trap2.show()	
	$trap.enableDamage()
	$trap2.enableDamage()


func _on_PlatformTrapTimer_timeout():
	if (hideTrap):
		hideTrap()
	else:
		showTrap()
		
	hideTrap = !hideTrap
