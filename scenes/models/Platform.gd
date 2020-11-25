extends KinematicBody2D

export var SPEED = 8000
export var playFallingAnimation = true
export var isPlatformTrap = false
export var canFallPlatform = true

var canTriggerFalling = true
var falling = false
var velocity = Vector2()
var originalPosition = Vector2()

func _ready():
	originalPosition = position
	add_to_group("plataform")		

func _physics_process(delta):
	if (falling and !isPlatformTrap and canFallPlatform):
		velocity.y = SPEED * delta
		position += velocity * delta		
		
func collide_with(collision : KinematicCollision2D, collider : KinematicBody2D):
	if (canFallPlatform and canTriggerFalling):
		canTriggerFalling = false
		_fall()
		
func _fall():
	velocity = Vector2.ZERO
	if (playFallingAnimation):
		$ShakeAnimation.play("PlatformAnimation")
		yield(get_tree().create_timer(.1), "timeout")
		$ShakeAnimation.stop()
	falling = true
	
func respawn():
	falling = false
	canTriggerFalling = true
	position = originalPosition
	
func destroy():
	respawn()
	
func hideTrap():
	$trap.hide()
	$trap2.hide()
	
func showTrap():
	$trap.show()
	$trap2.show()	
	
func _on_VisibilityNotifier2D_screen_exited():
	$PlatformRespawn.start()

func _on_PlatformRespawn_timeout():
	respawn() 

