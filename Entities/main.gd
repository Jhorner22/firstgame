extends Node

var score

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

func new_game():
	score = 0
	$StartTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_over():
	$ScoreTimer.stop()


func _on_score_timer_timeout():
	score += 1


func _on_start_timer_timeout():
	$ScoreTimer.start()
