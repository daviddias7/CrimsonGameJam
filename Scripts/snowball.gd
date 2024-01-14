extends Node2D

var time_stopped = false
var aux_vel

@onready var anim = $AnimationPlayer as AnimationPlayer
@onready var rig = $RigidBody2D as RigidBody2D
@onready var col = $RigidBody2D/Area2D as Area2D
@onready var world = $".."/".."/".."/".." as Node2D

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

func _on_area_2d_area_entered(area):
	if get_path_to(area) != get_path_to(get_parent().get_parent()):
		anim.play("poof")
		rig.angular_velocity = 0
		rig.constant_torque = 0
		rig.linear_velocity = rig.linear_velocity.normalized() * 200

		col.queue_free()
		
		if area.is_in_group("Enemy"):
			print("Enemy Killed")
			area.get_parent().hurt()
		elif area.is_in_group("Player"):
			area.get_parent().recieve_damage(1)
		elif area.is_in_group("Interactive"):
			area.get_parent().hitted()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "poof":
		queue_free()
