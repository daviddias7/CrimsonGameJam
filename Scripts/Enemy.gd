extends CharacterBody2D

const SPEED = 100.0

var last_direction = "right"
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = $AnimationPlayer as AnimationPlayer
@onready var player = get_parent().get_node("Player")

func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y += gravity * delta

	if last_direction == "left":
		anim.play("stop_left")
	elif last_direction == "right":
		anim.play("stop_right")
	elif last_direction == "up":
		anim.play("stop_up")
	elif last_direction == "down":
		anim.play("stop_down")
		
	# Get the input direction and handle the movement/deceleration.
	var direction = (player.position - position).normalized()
	
	if direction.x:
		velocity.x = direction.x * SPEED
		if direction.x < 0:
			anim.play("walk_left")
			last_direction = "left"
		else:
			anim.play("walk_right")
			last_direction = "right"
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction.y:
		velocity.y = direction.y * SPEED
		if !velocity.x:
			if direction.y > 0:
				anim.play("walk_up")
				last_direction = "up"
			else:
				anim.play("walk_down")
				last_direction = "down"
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	if !direction.x and !direction.y:
		anim.stop()
	
