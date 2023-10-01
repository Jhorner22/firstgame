extends CharacterBody2D

@onready var animations = $AnimationPlayer


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var is_attacking = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
#	if not is_on_floor():
#		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if velocity.x >= 0:
		animations.play("Player_Run_Right")
	if velocity.x <= 0:
		animations.play("Player_Run_Left")
	if velocity.x == 0:
		animations.play("Player_Idle")
	move_and_slide()
#
#func _on_animated_sprite_2d_animation_looped():
#	if animations. == "Attack":
#		is_attacking=false
#		animations.play("Idle")
