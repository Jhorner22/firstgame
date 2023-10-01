extends Area2D

signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


func _process(delta):
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_just_pressed("jump"):
		velocity.y = -100
	if Input.is_action_just_released("jump"):
		if velocity.y < -100:
			velocity.y = -100

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "Run"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	if velocity.x == 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play("Idle")

