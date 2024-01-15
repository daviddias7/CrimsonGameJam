extends CharacterBody2D


const SPEED = 300.0
const SLOW_SPEED = 150.0
const seconds_stopped = 2 # Em segundos

var health = 3;
var last_direction = "right"

var acting = false

var parrying = false
var can_parry = true

var can_time_magic = true

var walking_speed = SPEED
var walk_type = "walk_"

@onready var anim = $AnimationPlayer as AnimationPlayer
@onready var world = $".." as Node2D
@onready var parry_timer = $ParryTimer as Timer
@onready var time_magic_timer = $TimeMagicTimer as Timer

@onready var anim_magic = $"Camera2D/AnimationPlayer_magic" as AnimationPlayer




func _physics_process(delta):
	
	if Input.is_action_just_pressed("ui_accept") and can_time_magic:
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
	
	if Input.is_action_just_pressed("parry") and can_parry:
		if last_direction == "left":
			anim.play("parring_left")
		elif last_direction == "right":
			anim.play("parring_right")
		elif last_direction == "up":
			anim.play("parring_up")
		elif last_direction == "down":
			anim.play("parring_down")
		acting = true
		parrying = true

	if !acting:
		var direction_x = Input.get_axis("ui_left", "ui_right")
		var direction_y = Input.get_axis("ui_down", "ui_up")
		
		if direction_x:
			velocity.x = direction_x * walking_speed
			if direction_x < 0:
				last_direction = "left"
			else:
				last_direction = "right"
			anim.play(walk_type + last_direction)
		else:
			velocity.x = move_toward(velocity.x, 0, walking_speed)
			
		if direction_y:
			velocity.y = -direction_y * walking_speed
			if !velocity.x:
				if direction_y > 0:
					last_direction = "up"
				else:
					last_direction = "down"
			anim.play(walk_type + last_direction)
		else:
			velocity.y = move_toward(velocity.y, 0, walking_speed)

		move_and_slide()
		if !direction_x and !direction_y:
			anim.stop()

func time_magic ():
	can_time_magic = false
	anim_magic.play("use_magic")
	time_magic_timer.start(10)
	
	world.timming = false
	await get_tree().create_timer(0.3).timeout
	world.mod = 0xa6a6b0ff
	walking_speed = SLOW_SPEED
	walk_type = "slow_walk_"
	await get_tree().create_timer(seconds_stopped - 0.3).timeout
	world.timming = true
	world.mod = 0xffffffff
	walking_speed = SPEED
	walk_type = "walk_"
	pass

func recieve_damage(damage):
	world.timming = false
	world.mod = 0xa6a6b0ff
	anim.play("death")
	acting = true

func _on_animation_player_animation_finished(anim_name):
	if anim_name.begins_with("stop_"):
		acting = false
	elif anim_name.begins_with("parring_"):
		acting = false
		parrying = false
		can_parry = false
		parry_timer.start(0.5)
	elif anim_name == "death":
		pass
		
func is_parrying():
	return parrying

func _on_parry_timer_timeout():
	can_parry = true


func _on_time_magic_timer_timeout():
	can_time_magic = true
	anim_magic.play("has_magic")


func _on_animation_player_magic_animation_finished(anim_name):
	if anim_name == "use_magic":
		anim_magic.play("hasnt_magic")
