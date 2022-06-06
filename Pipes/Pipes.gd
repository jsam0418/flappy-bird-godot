extends RigidBody2D
signal left_screen

export var pipe_velocity = Vector2(-200,0)
var start_bool = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func start(pos):
	position = pos
	start_bool = true
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(start_bool):
		position += pipe_velocity*delta

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("left_screen")
	queue_free()
	
func stop():
	start_bool = false
