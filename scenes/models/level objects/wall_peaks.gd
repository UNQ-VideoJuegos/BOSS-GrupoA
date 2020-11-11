extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func disableDamage():
	$Node2D/peak/CollisionShape2D.disabled = true
	$Node2D/peak2/CollisionShape2D.disabled = true
	$Node2D/peak3/CollisionShape2D.disabled = true
	$Node2D/peak4/CollisionShape2D.disabled = true
	$Node2D/peak5/CollisionShape2D.disabled = true
	$Node2D/peak6/CollisionShape2D.disabled = true
	$Node2D/peak7/CollisionShape2D.disabled = true
	$Node2D/peak8/CollisionShape2D.disabled = true

func enableDamage():
	$Node2D/peak/CollisionShape2D.disabled = false
	$Node2D/peak2/CollisionShape2D.disabled = false
	$Node2D/peak3/CollisionShape2D.disabled = false
	$Node2D/peak4/CollisionShape2D.disabled = false
	$Node2D/peak5/CollisionShape2D.disabled = false
	$Node2D/peak6/CollisionShape2D.disabled = false
	$Node2D/peak7/CollisionShape2D.disabled = false
	$Node2D/peak8/CollisionShape2D.disabled = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
