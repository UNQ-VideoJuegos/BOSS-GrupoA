extends KinematicBody2D

signal health_updated(health)
signal killed()


export (PackedScene) var Bullet
export (float) var gun_cooldown = 0.1
export (float) var dash_cooldown = 2
export (float) var max_health = 100
export(PackedScene) var dash_object

onready var health = max_health setget _set_health
onready var invulnerability_timer = $invulnerabilityTimer
onready var animation = $AnimatedSprite


const FLOOR_NORMAL = Vector2.UP
var velocity = Vector2()
var move_direction
var speed = 350

var gravity = 600

var can_shoot = true

var dash_impulse = 10
var dash_length = 0.2 # ??
var can_dash = true

var jump_force = -400
var min_jump = -100
var is_jumping = false
var jump_intents = 2

func _ready():
	$GunTimer.wait_time = gun_cooldown
	$DashTimer.wait_time = dash_cooldown


func _apply_movement():
	$GunPosition.look_at(get_global_mouse_position())
	velocity = move_and_slide(velocity,FLOOR_NORMAL)
	_handleCollision()


func _move_input():
	move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	
	velocity.x = lerp(velocity.x,speed * move_direction, 0.2) 
	if move_direction != 0:
		$AnimatedSprite.flip_h = move_direction < 0

func _apply_gravity(delta):
	velocity.y += gravity * delta

func _jump():
	if is_on_floor():
		jump_intents = 2
	if Input.is_action_just_pressed("jump") and jump_intents > 0:
		velocity.y = jump_force
		$JumpSound.play()
		jump_intents -=1
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = min_jump

func _shoot():
	if can_shoot and Input.is_action_pressed("click"):
		can_shoot = false
		$GunTimer.start()
		_shoot_bullet()

func _shoot_bullet(): 
	var dir = Vector2(1,0).rotated($GunPosition.global_rotation)
	var b = Bullet.instance()
	owner.add_child(b)
	b.start($GunPosition.global_position,dir)

func _dash():
	if can_dash and Input.is_action_just_pressed("dash"):
		can_dash = false
		$DashTimer.start()
		velocity.x *= dash_impulse
		var dash_effect = dash_object.instance()
		dash_effect.texture = $AnimatedSprite.frames.get_frame($AnimatedSprite.animation,$AnimatedSprite.frame)
		dash_effect.position = global_position
		dash_effect.flip_h =$AnimatedSprite.flip_h
		dash_effect.modulate = modulate
		dash_effect.transform = $AnimatedSprite.global_transform
		get_parent().add_child(dash_effect)


func _handleCollision():
	for i in get_slide_count():
		var col = get_slide_collision(i)
		if (col.collider.has_method("collide_with")):
			col.collider.collide_with(col, self)

func _on_DashTimer_timeout():
	can_dash = true

func _on_GunTimer_timeout():
	can_shoot = true


func damage(amount):
	if invulnerability_timer.is_stopped():
		invulnerability_timer.start()
		_set_health(health - amount)
		$HealthDisplay.update_healthbar(health - amount)
		animation.play("hitw")

func kill():
	$GamerOverSound.play()
	$GunTimer.stop()
	$Camera2D.current = false
	$CollisionShape2D.set_deferred("disable",true)
	hide()
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().change_scene("res://scenes/menu/GameOverHUD.tscn")
	queue_free()
	

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health <= 0:
			kill()

func _on_invulnerabilityTimer_timeout():
	#effects_animation.play("rest")
	pass

func _on_Player_killed():
	kill()
