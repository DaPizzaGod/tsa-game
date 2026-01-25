extends Node

var mode := "normal"
var max_count := 2
var switch_mode_menu:PackedScene = preload("res://scenes/ui/switch_mode_menu.tscn")
var level:PackedScene = preload("res://scenes/levels/level.tscn")
var menu: Control
var modes := ["normal", "stretch", "spring"]
var count := 0

func _process(_delta: float) -> void:
	# When shift is pressed
	if Input.is_action_just_pressed("switch mode"):
		Engine.time_scale = 0.2
		menu = switch_mode_menu.instantiate()
		get_tree().get_root().add_child(menu)
		
		var menu_stay := Timer.new()
		add_child(menu_stay)
		menu_stay.wait_time = .1
		menu_stay.timeout.connect(_on_menu_stay_timeout)
		menu_stay.one_shot = true
		menu_stay.start()
		
		

		if count != max_count:
			count += 1
		else:
			count = 0
		mode = modes[count]
		print(mode)

func _on_menu_stay_timeout():
	print(typeof(menu), menu)
	menu.queue_free()
	Engine.time_scale = 1
	
