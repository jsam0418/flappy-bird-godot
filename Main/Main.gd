extends Node
export(PackedScene) var pipes_scene

# Declare member variables here. Examples:
var pipe_list = []
export var pipe_count = 3
var projectResolution
var rand_generate = RandomNumberGenerator.new()
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	rand_generate.randomize()
	projectResolution=get_viewport().size

func start_game():
	$Music.play()
	$Player.start($StartingPosition.position)
	$Player.z_index = 1
	new_pipe()
	$PipeTimer.start()
	
	
func new_pipe(xPos = projectResolution.x+60):
	var yPos = projectResolution.y/2
	yPos += rand_generate.randi_range(-projectResolution.y/4, projectResolution.y/4)
	var pipe = pipes_scene.instance()
	pipe.connect("score", self, "update_score")
	pipe.z_index = 2
	add_child(pipe)
	pipe.start(Vector2(xPos, yPos), $Player.position.x) 
	return pipe

func _on_Player_hit():
	# Stop the pipes moving
	# stop spawning Pipes
	$Music.stop()
	$DeathSound.play()
	get_tree().call_group("Pipes", "queue_free")
	$PipeTimer.stop()
	$HUD.showGameOver()
	score = 0


func _on_PipeTimer_timeout():
	new_pipe()

func update_score():
	score += 1
	$HUD.updateScore(score)
