extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var _animatedSprite = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	setup_animation()
	
func _physics_process(delta):
	process_animation()
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("ui_left", "ui_right",  "ui_up", "ui_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func setup_animation():
	_animatedSprite.animation = "idle"
	_animatedSprite.play()
	_animatedSprite.speed_scale = 1

func process_animation():
	if velocity.x < 0:
		_animatedSprite.flip_h = true 
	else:
		if velocity.x > 0:
			_animatedSprite.flip_h = false 
	
	var direction = Input.get_vector("ui_left", "ui_right",  "ui_up", "ui_down")
	if direction:
		_animatedSprite.play("walk")
	else:
		_animatedSprite.play("idle", 1)


