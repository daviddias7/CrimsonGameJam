extends Node2D

@export var timming = true
@export var mod = Color.hex(0xffffffff)
@export var num = 0

@onready var tiles = $TileMap as TileMap


func _process(delta):
	tiles.modulate = mod
