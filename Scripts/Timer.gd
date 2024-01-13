extends Timer

const BALL_SPEED = 500.0
const snowball_scene = preload("res://snowball.tscn")

func _on_timeout():
	var snowball_instance = snowball_scene.instantiate()
	snowball_instance.position = get_parent().position
	snowball_instance.get_node("RigidBody2D").linear_velocity = BALL_SPEED * (get_parent().get_parent().get_node("Player").position - snowball_instance.position).normalized()
	add_child(snowball_instance)
	wait_time = randf_range(0, 1)
