extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = $AnimationPlayer as AnimationPlayer

func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		#velocity.y = JUMP_VELOCITY
		anim.pause()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_down", "ui_up")
	
	if direction_x:
		velocity.x = direction_x * SPEED
		if direction_x < 0:
			anim.play("walk_left")
		else:
			anim.play("walk_right")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction_y:
		velocity.y = -direction_y * SPEED
		if !velocity.x:
			if direction_y > 0:
				anim.play("walk_up")
			else:
				anim.play("walk_down")
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	print(velocity.x)
	move_and_slide()
