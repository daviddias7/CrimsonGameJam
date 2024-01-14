extends Node2D

var time_stopped = false
var aux_vel
var parried

@onready var anim = $AnimationPlayer as AnimationPlayer
@onready var rig = $RigidBody2D as RigidBody2D
@onready var col = $RigidBody2D/Area2D as Area2D
@onready var world = $".."/".."/".."/".." as Node2D

func _ready():
	parried = false
	pass

func _physics_process(delta):
	if world.timming:
		if time_stopped:
			rig.freeze = false
			rig.sleeping = false
			anim.play()
			rig.linear_velocity = aux_vel
			self.modulate = world.mod
	else:
		aux_vel = rig.linear_velocity
		time_stopped = true
		rig.freeze = true
		anim.pause()
		self.modulate = world.mod

func ball_exploded():
	anim.play("poof")
	rig.angular_velocity = 0
	rig.constant_torque = 0
	rig.linear_velocity = rig.linear_velocity.normalized() * 200

	col.queue_free()

func _on_area_2d_area_entered(area):
	if get_path_to(area) != get_path_to(get_parent().get_parent()) or parried:
		if area.is_in_group("Enemy"):
			area.get_parent().hurt()
		elif area.is_in_group("Player"):
			if area.get_parent().is_parrying():
				
				var ball_dir = -rig.linear_velocity.normalized()
				var player_dir_txt = area.get_parent().last_direction
				var player_dir
				if(player_dir_txt == "right"):
					player_dir = Vector2.RIGHT
				elif(player_dir_txt == "left"):
					player_dir = Vector2.LEFT
				elif(player_dir_txt == "up"):
					player_dir = Vector2.UP
				else:
					player_dir = Vector2.DOWN
				
				var dot_product = (ball_dir.x * player_dir.x) + (ball_dir.y * player_dir.y)
				
				if(dot_product > 0.4):
					parried = true
					rig.linear_velocity = -rig.linear_velocity
					return
				else:
					area.get_parent().recieve_damage()
			else:
				area.get_parent().recieve_damage()
		ball_exploded()
		
		
		

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "poof":
		queue_free()
