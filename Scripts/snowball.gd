extends Node2D

var time_stopped = false

@onready var anim = $AnimationPlayer as AnimationPlayer
@onready var rig = $RigidBody2D as RigidBody2D
@onready var col = $RigidBody2D/Area2D as Area2D
@onready var world = $".."/".."/".."/".." as Node2D

func _ready():
	pass
	
func _process(delta):
	if world.timming:
		if time_stopped:
			rig.freeze = false
			anim.play()
	else:
		time_stopped = true
		anim.pause()


func _on_area_2d_area_entered(area):
	if get_path_to(area) != get_path_to(get_parent().get_parent()):
		anim.play("poof")
		rig.lock_rotation = true
		rig.angular_velocity = 0
		rig.constant_torque = 0
		rig.linear_velocity = rig.linear_velocity.normalized() * 200

		col.queue_free()
		
		if area.is_in_group("Enemy"):
			print("Enemy Killed")
			area.get_parent().hurt()
		elif area.is_in_group("Player"):
			area.get_parent().recieve_damage()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "poof":
		queue_free()
