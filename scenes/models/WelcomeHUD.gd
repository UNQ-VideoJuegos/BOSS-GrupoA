extends CanvasLayer

func _ready():
	$OptionsHUD._hide()
	_show()

func _show():
	$GameName.visible = true
	$StartGame.visible = true
	$OptionsButton.visible = true
	$Controls.visible = true

func _hide():
	$GameName.visible = false
	$StartGame.visible = false
	$OptionsButton.visible = false
	$Controls.visible = false

func _on_OptionsButton_pressed():
	_hide()
	$OptionsHUD._show()
	
func _on_BackButton_pressed():
	$OptionsHUD._hide()
	_show()
