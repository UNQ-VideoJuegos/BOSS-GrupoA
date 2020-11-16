extends KinematicBody2D


const SPEED = 20
const DOOR_OPEN_LIMIT = -25
const DOOR_CLOSE_LIMIT = 1

var opening = false
var closing = false

var velocity = Vector2()

func _ready():
	pass

func open():
	$DoorOpenTimer.start()

func close():
	opening = false
	$DoorCloseTimer.start()
	
func _physics_process(delta):
	if (opening):
		position.y -= SPEED * delta
		if (position.y < DOOR_OPEN_LIMIT):
			close()
			
	if (closing):
		position.y += SPEED * delta
		if (position.y > DOOR_CLOSE_LIMIT):
			closing = false

func _on_DoorTimer_timeout():
	opening = true

func _on_DoorCloseTimer_timeout():
	closing= true 
