extends Node

var mode := "normal"
var switch_mode_menu:PackedScene = preload("res://scenes/ui/switch_mode_menu.tscn")
var menu_root:Control
var menu: Control
var modes := [
	"normal", 
	"stretch", 
	"spring",
	"slide"
	]
var check_mode:= false
var new_player_pos
var menu_count:= 0

func _process(_delta: float) -> void:
	# When shift is pressed
	if Input.is_action_just_pressed("switch mode") and menu_count == 0 and StaminaCalc.current_stamina >= 1:
		Engine.time_scale = 0.1
		menu_count += 1
		menu = switch_mode_menu.instantiate()
		menu_root.add_child(menu)
		print(mode)
		# remove stamina
		StaminaCalc.current_stamina -= 1
		StaminaCalc.update_stamina = true
		print(StaminaCalc.current_stamina)
		
	
