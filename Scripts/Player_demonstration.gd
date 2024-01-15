extends CharacterBody2D

#
#const SPEED = 300.0
#const SLOW_SPEED = 150.0
const seconds_stopped = 2 # Em segundos

#var health = 3;
var last_direction = "left"
#var acting = false
var parrying = false
var can_parry = true
#var walking_speed = SPEED
#var walk_type = "walk_"
@onready var anim = $AnimationPlayer as AnimationPlayer
@onready var world = $".." as Node2D
#@onready var timer = $Timer as Timer

@export var to_parry = false as bool
@export var to_stop = false as bool

var timer_okay = true

func _physics_process(delta):

	if to_stop and timer_okay:
		timer_okay = false
		if last_direction == "left":
			anim.play("stop_left")
		elif last_direction == "right":
			anim.play("stop_right")
		elif last_direction == "up":
			anim.play("stop_up")
		elif last_direction == "down":
			anim.play("stop_down")
		#acting = true
		time_magic()
	
	elif to_parry:
		if last_direction == "left":
			anim.play("parring_left")
		elif last_direction == "right":
			anim.play("parring_right")
		elif last_direction == "up":
			anim.play("parring_up")
		elif last_direction == "down":
			anim.play("parring_down")
		#acting = true
		parrying = true
#
	#if !acting:
		#var direction_x = Input.get_axis("ui_left", "ui_right")
		#var direction_y = Input.get_axis("ui_down", "ui_up")
		#
		#if direction_x:
			#velocity.x = direction_x * walking_speed
			#if direction_x < 0:
				#last_direction = "left"
			#else:
				#last_direction = "right"
			#anim.play(walk_type + last_direction)
		#else:
			#velocity.x = move_toward(velocity.x, 0, walking_speed)
			#
		#if direction_y:
			#velocity.y = -direction_y * walking_speed
			#if !velocity.x:
				#if direction_y > 0:
					#last_direction = "up"
				#else:
					#last_direction = "down"
			#anim.play(walk_type + last_direction)
		#else:
			#velocity.y = move_toward(velocity.y, 0, walking_speed)

		#move_and_slide()
		#if !direction_x and !direction_y:
			#anim.stop()

func time_magic ():
	world.timming = false
	await get_tree().create_timer(0.3).timeout
	world.mod = 0xa6a6b0ff
	#walking_speed = SLOW_SPEED
	#walk_type = "slow_walk_"
	await get_tree().create_timer(seconds_stopped - 0.3).timeout
	world.timming = true
	world.mod = 0xffffffff
	#walking_speed = SPEED
	#walk_type = "walk_"
	await get_tree().create_timer(5).timeout
	timer_okay = true
	pass
#
func recieve_damage(damage):
	##print("Player Damaged")
	#health -= damage
	##if health == 0:
		##print("Game Over")
	pass

		
func is_parrying():
	return parrying

func _on_timer_timeout():
	can_parry = true


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "stop_left":
		anim.play("walk_left")
