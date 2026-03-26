extends Control


func _on_button_pressed() -> void:
	if LevelCalc.finishing_level:
		LevelCalc.menu_to_first_level()



func _ready() -> void:
	while 1:
		var tween := create_tween()
		tween.tween_property($Background, "scale", Vector2(0.2, 0.2), 0.1)
		await tween.finished
		tween.tween_property($Background, "scale", Vector2(0.1, 0.1), 0.1)
		await  tween.finished
