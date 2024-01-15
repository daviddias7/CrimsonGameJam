extends Node2D

@export var timming = true
@export var mod = Color.hex(0xffffffff)

@onready var butt = $Button as Button
@onready var start_level = preload("res://node_2d.tscn") as PackedScene
@onready var menu = preload("res://main_menu/main_menu.tscn") as PackedScene

func _on_button_button_down():
	get_tree().change_scene_to_packed(start_level)
	


func _on_button_2_button_down():
	get_tree().change_scene_to_packed(menu)
