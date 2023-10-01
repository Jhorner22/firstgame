extends CharacterBody2D

@onready var animations = $AnimationPlayer
@onready var anim_tree = $AnimationTree
@onready var anim_state = anim_tree.get("parameters/playback")

enum player_states {MOVE, ATTACK, JUMP, DEAD}
var current_state = player_states.MOVE

var direction = Vector2.ZERO
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var is_attacking = false
var input_movement = Vector2.ZERO
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _ready():
	direction = Vector2(0,1)

func _physics_process(delta):
	match current_state:
		player_states.MOVE:
			move()
		player_states.ATTACK:
			attack()
		player_states.JUMP:
			jump()
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
	
	if Input.is_action_just_pressed("attack"):
		current_state = player_states.ATTACK


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
	move_and_slide()
#
func attack():
	anim_state.travel("Attack")
	
func jump():
	pass
	
func on_state_reset():
	current_state = player_states.MOVE
	
