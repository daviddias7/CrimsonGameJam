extends Control

@onready var next_button = $Button as Button
@onready var anim = $AnimationPlayer as AnimationPlayer
@onready var start_level = preload("res://main_menu/Tutorial_1.tscn") as PackedScene

var phase = 0

func _on_button_button_down():
	phase = phase + 1
	if phase == 1:
		anim.play("go_to_1")
	elif phase == 2:
		anim.play("go_to_2")
	elif phase == 3:
		anim.play("go_to_3")
	elif phase == 4:
		anim.play("go_to_4")
	elif phase == 5:
		anim.play("go_to_5")
	else:
		get_tree().change_scene_to_packed(start_level)
	
