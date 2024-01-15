extends Node2D

@export var timming = true
@export var mod = Color.hex(0xffffffff)

@onready var tiles = $TileMap as TileMap
const enemy_scene = preload("res://prefabs/enemy_1.tscn")

@onready var enemy_spawner = $EnemySpawner as Timer
@onready var player = $Player as CharacterBody2D

func _process(delta):
	tiles.modulate = mod

func _on_enemy_spawner_timeout():
	var enemy_instance = enemy_scene.instantiate()
	#var x = player.position.x + 1152 if player.position.x + 1152 < 750 else player.position.x - 1152
	#var y = player.position.y + 648 if player.position.y + 648 < 650 else player.position.y - 648
	enemy_instance.position = Vector2(0, 0)
	add_child(enemy_instance)
