extends Node


var current_level
var max_level:= 12
var levels = {
	1 : "res://scenes/levels/level_1.tscn",
	2 : "res://scenes/levels/level_2.tscn",
	3 : "res://scenes/levels/level_3.tscn",
	4 : "res://scenes/levels/stretch_shrine.tscn",
	5 : "res://scenes/levels/level_4.tscn",
	6 : "res://scenes/levels/level_5.tscn",
	7 : "res://scenes/levels/level_6.tscn" , 
	8 : "res://scenes/levels/spring_shrine.tscn", 
	9 : "res://scenes/levels/level_7.tscn",
	10 : "res://scenes/levels/level_8.tscn", 
	11 : "res://scenes/levels/level_9.tscn",
	12 : "res://scenes/levels/level_10.tscn"
}
signal finish_level()
var finishing_level := true
var loading_screen_root
func _ready() -> void:
	current_level = levels.get(1)
	print(current_level)
	connect("finish_level", _on_finish_level)
	
func _on_finish_level():
	if finishing_level:
		finishing_level = false
		await get_tree().create_timer(0.1).timeout
		
		ThrowCalc.current_lanterns = 0
		print("finished")
		#current_level = get_tree().current_scene.scene_file_path
		print(levels.find_key(current_level))
		var next_level_num :int = (levels.find_key(current_level)) + 1
		if next_level_num > max_level:
			print("too high")
			return
		
		var next_level_path = levels.get(next_level_num)
		print(next_level_path)
		get_tree().change_scene_to_file(next_level_path) 
		
		await get_tree().create_timer(0.05).timeout
		StaminaCalc.current_stamina = 0
		current_level = next_level_path
		await get_tree().create_timer(2.0).timeout
		finishing_level = true
		if is_instance_valid(ThrowCalc.new_loading_screen):
			ThrowCalc.new_loading_screen.queue_free()
			print(is_instance_valid(ThrowCalc.new_loading_screen))
		else:
			print(is_instance_valid(ThrowCalc.new_loading_screen))
	
func menu_to_first_level():
	if finishing_level:
		finishing_level = false
		ThrowCalc.new_loading_screen = ThrowCalc.loading_screen.instantiate()
		get_tree().root.add_child(ThrowCalc.new_loading_screen)
		get_tree().change_scene_to_file(levels.get(1))
		await get_tree().create_timer(2.0).timeout
		finishing_level = true
		if is_instance_valid(ThrowCalc.new_loading_screen):
			ThrowCalc.new_loading_screen.queue_free()
			print(is_instance_valid(ThrowCalc.new_loading_screen))
		else:
			print(is_instance_valid(ThrowCalc.new_loading_screen))
	
