extends Node

var mode := "normal"
var switch_mode_menu:PackedScene = preload("res://scenes/ui/switch_mode_menu.tscn")
var level:PackedScene = preload("res://scenes/levels/level.tscn")
var menu: Control
var modes := [
	"normal", 
	"stretch", 
	"spring",
	"slide"
	]
var check_mode:= false
var new_player_pos

func _process(_delta: float) -> void:
	# When shift is pressed
	if Input.is_action_just_pressed("switch mode"):
		Engine.time_scale = 0.1
		menu = switch_mode_menu.instantiate()
		get_tree().get_root().add_child(menu)
		print(mode)
		
	

func _on_menu_stay_timeout():
	print(typeof(menu), menu)
	menu.queue_free()
	Engine.time_scale = 1
	
