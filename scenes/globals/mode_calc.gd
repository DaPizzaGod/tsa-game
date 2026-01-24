extends Node

var mode := "normal"
var max_count := 2
var switch_mode_menu:PackedScene = preload("res://scenes/ui/switch_mode_menu.tscn")
var level:PackedScene = preload("res://scenes/levels/level.tscn")
var menu

var modes := ["normal", "stretch", "spring"]
var count := 0

func _process(_delta: float) -> void:
	# When shift is pressed
	if Input.is_action_just_pressed("switch mode"):
		print("hello")
		menu = switch_mode_menu.instantiate()
		get_tree().get_root().add_child(menu)
		
		

		if count != max_count:
			count += 1
		else:
			count = 0
		mode = modes[count]
		print(mode)
