extends Node

var max_stamina:= 15
var current_stamina: int
var update_stamina:= false
var respawn:= false
var check_if_over := false


func _ready() -> void: 
	current_stamina = max_stamina
	LevelCalc.connect("finish_level", _on_finish_level)

func _process(_delta: float) -> void:
	if check_if_over:
		if current_stamina > max_stamina:
			current_stamina = max_stamina
		check_if_over = false
		update_stamina = true
	
	
	if current_stamina <= 0:
		get_tree().change_scene_to_file("res://scenes/player/player.tscn")
		get_tree().change_scene_to_file(LevelCalc.current_level)
		current_stamina = max_stamina
		respawn = true
		update_stamina = true
	
	if Input.is_action_just_pressed("restart"):
		current_stamina = 0
func _on_finish_level():
	current_stamina = max_stamina
	update_stamina = true
