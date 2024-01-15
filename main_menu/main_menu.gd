class_name MainMenu
extends Control


@onready var newgame = $MarginContainer/HBoxContainer/VBoxContainer/Newgame as Button
@onready var options = $MarginContainer/HBoxContainer/VBoxContainer/Options as Button
@onready var credits = $MarginContainer/HBoxContainer/VBoxContainer/Credits as Button
@onready var exit = $MarginContainer/HBoxContainer/VBoxContainer/Exit as Button
@onready var start_level = preload("res://main_menu/Story.tscn") as PackedScene

func _ready():
	MusicController.play_music()
	newgame.button_down.connect(on_start_pressed)
	exit.button_down.connect(on_exit_pressed)
	
	
func on_start_pressed() -> void:
		get_tree().change_scene_to_packed(start_level)
	
func on_exit_pressed() -> void:
		get_tree().quit()
