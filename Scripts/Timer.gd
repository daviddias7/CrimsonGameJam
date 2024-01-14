extends Timer

# Spawn de projetil
const min_time = 0.2
const max_time = 1

const BALL_SPEED = 600.0
const snowball_scene = preload("res://snowball.tscn")
const desvio_angular = 0.1 #angulo em radianos

var indicator = false # false = fazer animação // true = spawnar bola de neve
@onready var enemy = $"../.." as CharacterBody2D

func _process(delta):
	if wait_time > 1:
		wait_time = 0.2
	
func _on_timeout():
	print(wait_time)
	if indicator:
		wait_time = 0.2
	else:
		wait_time = randf_range(min_time, max_time)
	enemy.attack(indicator)
	indicator = !indicator
	
func spawn_snowball():
	var snowball_instance = snowball_scene.instantiate()
	snowball_instance.position = get_parent().get_parent().position
	snowball_instance.get_node("RigidBody2D").linear_velocity = BALL_SPEED * ((get_parent().get_parent().get_parent().get_node("Player").position - snowball_instance.position).normalized() + Vector2(randf_range(-1,1), randf_range(-1,1)).normalized() * desvio_angular)
	add_child(snowball_instance)

func time_stopp():
	self.pause = true
	
func time_play():
	self.pause = false
