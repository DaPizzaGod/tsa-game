extends Node

var current_level
var max_level:= 2
var levels = {
	1 : "res://scenes/levels/level_1.tscn",
	2 : "res://scenes/levels/level_2.tscn"
}
signal finish_level()

func _ready() -> void:
	current_level = levels.get(1)
	print(current_level)
	connect("finish_level", _on_finish_level)
	
func _on_finish_level():
	ThrowCalc.current_lanterns = 0
	print("finished")
	current_level = get_tree().current_scene.scene_file_path
	var next_level_num :int = (levels.find_key(current_level)) + 1
	if next_level_num > max_level:
		print("too high")
		return
	
	var next_level_path = levels.get(next_level_num)
	
	get_tree().change_scene_to_file(next_level_path)
	
	await get_tree().create_timer(0.05).timeout
	StaminaCalc.current_stamina = 0
	current_level = get_tree().current_scene.scene_file_path
	
	
