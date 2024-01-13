extends Timer

var snowball_scene = preload("res://snowball.tscn")
var BALL_SPEED = 300.0

func _on_timeout():
	var snowball_instance = snowball_scene.instantiate()
	snowball_instance.position = Vector2(randf_range(10, 990), randf_range(10, 590))
	snowball_instance.get_node("RigidBody2D").linear_velocity = BALL_SPEED * Vector2(randf_range(0, 1), randf_range(0, 1)).normalized()
	add_child(snowball_instance)
	wait_time = randf_range(0, 1)
