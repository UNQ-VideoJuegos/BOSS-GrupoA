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
	$trap3.hide()
	$trap4.hide()		
	$trap.disableDamage()
	$trap2.disableDamage()
	$trap3.disableDamage()
	$trap4.disableDamage()		
	
func showTrap():
	$trap.show()
	$trap2.show()
	$trap3.show()
	$trap4.show()		
	$trap.enableDamage()
	$trap2.enableDamage()
	$trap3.enableDamage()
	$trap4.enableDamage()		


func _on_PlatformTrapTimer_timeout():
	if (hideTrap):
		hideTrap()
	else:
		showTrap()
		
	hideTrap = !hideTrap
