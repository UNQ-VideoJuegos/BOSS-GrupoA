extends Node2D

signal triggered

const SPEED = 50

var movingDown = false
var movingUp = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if (movingDown):
		position.y -= SPEED * delta
			
	if (movingUp):
		position.y += SPEED * delta
			
	

func _on_Interruptor_area_entered(area):
	if (area.get_name() == "Bullet"):
		emit_signal('triggered') 
		$Sprite.hide()
		$AnimatedSprite.show()
		$AnimatedSprite.play()
		yield(get_tree().create_timer(.5), "timeout")		
		$AnimatedSprite.stop()
		$AnimatedSprite.hide()
		$AnimatedSprite.frame = 0
		$RespawnTimer.start()

func _on_Interruptor_triggered():
	$MoveDownTimer.start()
	
func _on_RespawnTimer_timeout():
	$Sprite.show()


func _on_MoveDownTimer_timeout():
	movingDown = false
	movingUp = true
	$MoveUpTimer.start()

func _on_MoveUpTimer_timeout():
	movingDown = true
	movingUp = false 
	$MoveDownTimer.start()
