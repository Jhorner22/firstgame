extends CharacterBody2D

@onready var animations = $AnimationPlayer

var current_status = player_states.MOVE
enum player_states {MOVE, ATTACK}

var direction = Vector2.ZERO

@onready var anim_tree = $AnimationTree
@onready var anim_state = anim_tree.get("parameters/playback")

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var is_attacking = false
var input_movement = Vector2.ZERO
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _ready():
	direction = Vector2(0,1)

func _physics_process(delta):
	match current_status:
		player_states.MOVE:
			move()
		player_states.ATTACK:
			attack()
	if not is_on_floor():
		velocity.y += gravity * delta
	
	
func move():
	input_movement = Input.get_axis("move_left","move_right")
	
	if input_movement != 0:
		velocity.x = input_movement * SPEED
		anim_tree.set("parameters/Idle/blend_position", input_movement)
		anim_tree.set("parameters/Run/blend_position", velocity.x)
		anim_tree.set("parameters/Attack/blend_position", input_movement)
		anim_state.travel("Run")
		
	if input_movement == 0:
		anim_state.travel("Idle")
	


	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
#
#	if velocity.x >= 0:
#		animations.play("Player_Run_Right")
#	if velocity.x <= 0:
#		animations.play("Player_Run_Left")
#	if velocity.x == 0:
#		animations.play("Player_Idle")
	move_and_slide()
#
func attack():
	print("AH")
#func _on_animated_sprite_2d_animation_looped():
#	if animations. == "Attack":
#		is_attacking=false
#		animations.play("Idle")
