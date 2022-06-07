extends Area2D
signal hit
signal dead

# Declare member variables here. Examples:
export var bounce_velocity = Vector2(0,-500)
export var player_gravity = Vector2(0, 2000)
var velocity = Vector2.ZERO
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	reset()

func start(pos):
	set_process(true)
	position = pos
	show()
	$CollisionShape2D.disabled = false
	$AnimatedSprite.play("Flap")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Check for input, if jump is pressed then add the vertical Y velocity
	if($AnimatedSprite.animation == "Flap" and Input.is_action_just_pressed("jump")):
		velocity = bounce_velocity
		
	# Account for gravity
	velocity += player_gravity*delta
	
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("dead")
	reset()


func _on_FlappyBird_body_entered(body):
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite.stop()
	$AnimatedSprite.play("Fall")
	
func reset():
	set_process(false)
	hide()
	velocity = Vector2.ZERO
	$AnimatedSprite.stop()
	
