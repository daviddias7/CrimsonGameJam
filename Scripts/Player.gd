extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var last_direction = "right"
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = $AnimationPlayer as AnimationPlayer
#oi
func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if last_direction == "left":
			anim.play("stop_left")
		elif last_direction == "right":
			anim.play("stop_right")
		elif last_direction == "up":
			anim.play("stop_up")
		elif last_direction == "down":
			anim.play("stop_down")
		
		time_magic()
		
		if Input.is_action_just_pressed("parry"):
			if last_direction == "left":
				anim.play("parring_left")
			elif last_direction == "right":
				anim.play("parring_right")
			elif last_direction == "up":
				anim.play("parring_up")
			elif last_direction == "down":
				anim.play("parring_down")
			
			print("parring " + last_direction)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_down", "ui_up")
	
	if direction_x:
		velocity.x = direction_x * SPEED
		if direction_x < 0:
			anim.play("walk_left")
			last_direction = "left"
		else:
			anim.play("walk_right")
			last_direction = "right"
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction_y:
		velocity.y = -direction_y * SPEED
		if !velocity.x:
			if direction_y > 0:
				anim.play("walk_up")
				last_direction = "up"
			else:
				anim.play("walk_down")
				last_direction = "down"
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func time_magic ():
	print("time_magic()")
