extends Node2D

const explosion_range = 110
const explosion_damage = 5

var on = true
var exploding = false

@onready var col = $Area2D/CollisionShape2D as CollisionShape2D
@onready var anim = $AnimationPlayer as AnimationPlayer
@onready var world = $".." as Node2D


func _process(delta):
	self.modulate = world.mod
	
func hitted():
	if on:
		on = false
		explode()

func explode():
	anim.play("Explosion")
	exploding = true
	col.shape = CircleShape2D.new()
	col.shape.radius = explosion_range
	await get_tree().create_timer(0.2).timeout
	exploding = false
	col.queue_free()

func _on_area_2d_area_entered(area):
	if exploding:
		if area.is_in_group("Enemy"):
			area.get_parent().hurt()
		elif area.is_in_group("Player"):
			area.get_parent().recieve_damage(explosion_damage)
		elif area.is_in_group("Interactive"):
			area.get_parent().Hitted()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Explosion":
		anim.play("lefted")
