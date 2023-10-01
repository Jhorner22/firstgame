extends Node

var score

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

func new_game():
	$Player.start($StartPosition.position)
	$StartTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_over():
	$ScoreTimer.stop()
