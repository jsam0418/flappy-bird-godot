extends CanvasLayer
signal start

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Score.text = "0"
	$Message.text = "Flappy Bird!"
	$Message.show()
	$StartGameButton.show()
	

func updateMessage(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_StartGameButton_pressed():
	$StartGameButton.hide()
	updateMessage("Get Ready!")
	yield($MessageTimer, "timeout")
	$Message.hide()
	emit_signal("start")

func _on_MessageTimer_timeout():
	$Message.hide()

func updateScore(score):
	$Score.text = str(score)

func showGameOver():
	updateMessage("Game Over!")
	yield($MessageTimer, "timeout")
	updateScore(0)
	$Message.text = "Flappy Bird!"
	$Message.show()
	yield(get_tree().create_timer(1), "timeout")
	$StartGameButton.show()
