extends Control


func _on_button_pressed() -> void:
	if LevelCalc.finishing_level:
		LevelCalc.menu_to_first_level()
