extends Node
export(PackedScene) var pipes_scene

# Declare member variables here. Examples:
var pipe_list = []
export var pipe_count = 3
var projectResolution
var rand_generate = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	rand_generate.randomize()
	projectResolution=get_viewport().size
	start_game()

func start_game():
	$Player.start($StartingPosition.position)
	new_pipe()
	$PipeTimer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func new_pipe(xPos = projectResolution.x+60):
	var yPos = projectResolution.y/2
	yPos += rand_generate.randi_range(-projectResolution.y/4, projectResolution.y/4)
	var pipe = pipes_scene.instance()
	add_child(pipe)
	pipe.start(Vector2(xPos, yPos))
	return pipe

func _on_Player_hit():
	# Stop the pipes moving
	# stop spawning Pipes
	get_tree().call_group("Pipes", "queue_free")
	$PipeTimer.stop()


func _on_PipeTimer_timeout():
	new_pipe()
