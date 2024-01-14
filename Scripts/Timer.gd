extends Timer

const BALL_SPEED = 600.0
const snowball_scene = preload("res://snowball.tscn")
const desvio_angular = 0.1 #angulo em radianos

@onready var enemy = $"../.." as CharacterBody2D

func _on_timeout():
	enemy.attack()
	await get_tree().create_timer(0.2).timeout
	var snowball_instance = snowball_scene.instantiate()
	snowball_instance.position = get_parent().get_parent().position
	snowball_instance.get_node("RigidBody2D").linear_velocity = BALL_SPEED * ((get_parent().get_parent().get_parent().get_node("Player").position - snowball_instance.position).normalized() + Vector2(randf_range(-1,1), randf_range(-1,1)).normalized() * desvio_angular)
	add_child(snowball_instance)
	wait_time = randf_range(0.2, 1)
