extends KinematicBody2D

signal health_updated(health)
signal killed()


export (PackedScene) var Bullet
export (float) var gun_cooldown = 0.1
export (float) var dash_cooldown = 2
export (float) var max_health = 100


onready var health = max_health setget _set_health
onready var invulnerability_timer = $invulnerabilityTimer
onready var animation = $AnimatedSprite
#onready var anim = $AnimationPlayer #NO USAR POR AHORA


const FLOOR_NORMAL = Vector2.UP
const normal_speed = 350
const dash_speed = normal_speed * 4
var speed = normal_speed
var velocity = Vector2()
var move_direction
var right_orientation = true

var gravity = 600
var can_shoot = true

onready var dash_effect_timer = $DashEffect
export(PackedScene) var dash_object
var dash_impulse = 30
var dash_length = 0.2
var dash_direction = Vector2.RIGHT
var can_dash = true
var is_dashing = false

var jump_force = -400
var min_jump = -100
var is_jumping = false
var jump_intents = 2

var gun_position_right = Vector2(33,-28)
var gun_position_left = Vector2(-26,-28)

var is_dead = false

var arrow = preload("res://assets/miras/BlueCrosshair_19.png")

func _ready():
	$BackgroundSound.play()
	$GunTimer.wait_time = gun_cooldown
	$DashTimer.wait_time = dash_cooldown
	Input.set_custom_mouse_cursor(arrow,0,Vector2(50,50))


func _gun_direction():
	if !is_dead:
		$GunPosition.look_at(get_global_mouse_position())
		animation.flip_h = position.direction_to(get_global_mouse_position()).x < 0
		if !animation.flip_h:
			$GunPosition.position = gun_position_right
		else:
			$GunPosition.position = gun_position_left

func _apply_movement():
	if !is_dead:
		velocity = move_and_slide(velocity,FLOOR_NORMAL)
		_handleCollision()


func _move_input():
	move_direction = 0
	if !is_dead:
		if Input.is_action_pressed("move_right"):
			move_direction = 1
			$AnimatedSprite.flip_h = false
			dash_direction = Vector2.RIGHT
		if Input.is_action_pressed("move_left"):
			move_direction = -1
			$AnimatedSprite.flip_h = true
			dash_direction = Vector2.LEFT
		velocity.x = speed * move_direction
 
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
	if can_shoot and Input.is_action_pressed("click") and !is_dead:
		can_shoot = false
		$GunTimer.start()
		$fire.play()
		_shoot_bullet()

func _shoot_bullet(): 
	var dir = Vector2(1,0).rotated($GunPosition.global_rotation)
	var b = Bullet.instance()
	owner.add_child(b)
	b.start($GunPosition.global_position,dir)

func _dash():
	if Input.is_action_just_pressed("dash") and !is_dead:
		is_dashing = true
		$Particles2D.emitting = true
		$DashEffect.start(dash_length)
		$DashSound.play()
#		velocity.x *= dash_impulse
		speed = dash_speed
		if is_dashing:
			var dash_effect = dash_object.instance()
			dash_effect.texture = animation.frames.get_frame($AnimatedSprite.animation,animation.frame)
			dash_effect.global_position = animation.global_position
			dash_effect.flip_h = animation.flip_h
			get_parent().add_child(dash_effect)


func _handleCollision():
	for i in get_slide_count():
		var col = get_slide_collision(i)
		if (col.collider.has_method("collide_with")):
			col.collider.collide_with(col, self)


func _on_GunTimer_timeout():
	can_shoot = true


func damage(amount):
	if invulnerability_timer.is_stopped():
		invulnerability_timer.start()
		_set_health(health - amount)

func kill():
	is_dead = true
	$BackgroundSound.stop()
	$GamerOverSound.play()
	$health_low.stop()
	$GunTimer.stop()
	yield(get_tree().create_timer(0.8), "timeout")
	get_tree().change_scene("res://scenes/menu/GameOverHUD.tscn")

func _set_health(value):
	health = clamp(value, 0, max_health)
	emit_signal("health_updated", health)
	$HealthDisplay.update_healthbar(health)
	if health < max_health/2:
		$health_low.play()
	if health <= 0:
		kill()

func _on_invulnerabilityTimer_timeout():
	pass

func _on_Player_killed():
	kill()


func _on_DashEffect_timeout():
	$Particles2D.emitting = false
	is_dashing = false
	speed = normal_speed

