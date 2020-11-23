extends Node2D

signal triggered

const SPEED = 50

export var isMovingInterruptor = false

var movingDown = false
var movingUp = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$On.hide()	
	if (isMovingInterruptor):
		hide()

func _physics_process(delta):
	if (movingDown):
		position.y -= SPEED * delta
			
	if (movingUp):
		position.y += SPEED * delta
			
	

func _on_Interruptor_area_entered(area):
	if (area.get_name() == "Bullet"):
		emit_signal('triggered')
		$Off.hide()	
		$On.show()	
		modulate= Color.red
		$RespawnTimer.start()

func _on_Interruptor_triggered():
	show()
	$MoveDownTimer.start()
	
func _on_RespawnTimer_timeout():
	modulate= Color.white
	$On.hide()	
	$Off.show()


func _on_MoveDownTimer_timeout():
	movingDown = false
	movingUp = true
	$MoveUpTimer.start()

func _on_MoveUpTimer_timeout():
	movingDown = true
	movingUp = false 
	$MoveDownTimer.start()
