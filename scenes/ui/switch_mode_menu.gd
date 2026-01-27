extends Control



func _on_normal_button_pressed() -> void:
	change_mode(0)


func _on_stretch_button_pressed() -> void:
	change_mode(1)

func _on_spring_button_pressed() -> void:
	change_mode(2)
func _on_slide_button_pressed() -> void:
	change_mode(3)
	
	
func change_mode(item):
	
	ModeCalc.mode = ModeCalc.modes[item]
	print(ModeCalc.mode)
	Engine.time_scale = 1
	ModeCalc.check_mode = true
	ModeCalc.menu_count -= 1
	queue_free()
	
