extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var health = 3;
var last_direction = "right"
var acting = false;
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = $AnimationPlayer as AnimationPlayer
@onready var world = $".." as Node2D

func _physics_process(delta):

	if Input.is_action_just_pressed("ui_accept"):
		if last_direction == "left":
			anim.play("stop_left")
		elif last_direction == "right":
			anim.play("stop_right")
		elif last_direction == "up":
			anim.play("stop_up")
		elif last_direction == "down":
			anim.play("stop_down")
		acting = true
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
		acting = true

	if !acting:
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
		if !direction_x and !direction_y:
			anim.stop()

func time_magic ():
	world.timming = false
	await get_tree().create_timer(2).timeout
	world.timming = true
	pass

func recieve_damage():
	print("Player Damaged")
	health -= 1
	if health == 0:
		print("Game Over")

func _on_animation_player_animation_finished(anim_name):
	if anim_name.begins_with("stop_"):
		acting = false
	if anim_name.begins_with("parring_"):
		acting = false
