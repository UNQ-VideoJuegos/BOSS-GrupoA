extends Area2D

export var tipText = "A Tip"
var showArrow = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Tip.text = tipText
	$Tip.hide()
	$Arrow.hide()

func _on_HelpTip_body_entered(body):
	$Tip.show()
	$Arrow.show()
	showArrow = true
	$ArrowTimer.start()


func _on_HelpTip_body_exited(body):
	$TipTimer.start()
	

func _on_TipTimer_timeout():
	$Tip.hide()
	showArrow = false
	$ArrowTimer.stop()
	$Arrow.hide()


func _on_ArrowTimer_timeout():
	if(showArrow):
		$Arrow.show()
	else:
		$Arrow.hide()
		
	showArrow = !showArrow
