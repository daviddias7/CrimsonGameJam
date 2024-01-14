extends CharacterBody2D

const SPEED = 100.0

var last_direction = "right"
var acting = false
var dead = false
var time_stopped = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = $AnimationPlayer as AnimationPlayer
@onready var player = get_parent().get_node("Player")
@onready var spawner = $Area2D/Timer as Timer
@onready var col = $Area2D/CollisionShape2D as CollisionShape2D
@onready var world = $".." as Node2D


func _physics_process(delta):

	if world.timming:
		if time_stopped:
			play_time()

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
	else:
		stop_time()
	
func attack(indicator):
	if !acting and !indicator:
		var animation = "parring_" + last_direction
		anim.play(animation)
		acting = true
	elif indicator and !dead:
		spawner.spawn_snowball()
		print("spawned")


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

func stop_time():
	anim.pause()
	time_stopped = true
	spawner.paused = true

func play_time():
	anim.play()
	time_stopped = false
	spawner.paused = false
