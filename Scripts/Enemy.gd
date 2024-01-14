extends CharacterBody2D

const SPEED = 100.0

var last_direction = "right"
var acting = false
var dead = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = $AnimationPlayer as AnimationPlayer
@onready var player = get_parent().get_node("Player")
@onready var spawner = $Area2D/Timer as Timer
@onready var col = $Area2D/CollisionShape2D as CollisionShape2D

func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y += gravity * delta

	#if last_direction == "left":
	#	anim.play("stop_left")
	#elif last_direction == "right":
	#	anim.play("stop_right")
	#elif last_direction == "up":
	#	anim.play("stop_up")
	#elif last_direction == "down":
	#	anim.play("stop_down")
		
	# Get the input direction and handle the movement/deceleration.
	
	if !acting:
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
			if absf(velocity.x) < absf(velocity.y):
				if direction.y < 0:
					anim.play("walk_up")
					last_direction = "up"
				else:
					anim.play("walk_down")
					last_direction = "down"
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)

		move_and_slide()
	
func attack():
	if !acting:
		var animation = "parring_" + last_direction
		anim.play(animation)
		acting = true


func _on_animation_player_animation_finished(anim_name):
	if anim_name.begins_with("parring_"):
		acting = false
	elif anim_name == "death":
		queue_free()

func hurt():
	if !dead:
		anim.play("death")
		acting = true
		dead = true
		spawner.queue_free()
		await get_tree().create_timer(0.4).timeout
		col.queue_free()
