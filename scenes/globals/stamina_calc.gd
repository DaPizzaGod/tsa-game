extends Node

var max_stamina:= 30
var current_stamina: int
var update_stamina:= false
var respawn:= false
var check_if_over := false


func _ready() -> void: 
	current_stamina = max_stamina

func _process(_delta: float) -> void:
	if check_if_over:
		if current_stamina > max_stamina:
			current_stamina = max_stamina
		check_if_over = false
		update_stamina = true
	
	
	if current_stamina <= 0:
		get_tree().change_scene_to_file("res://scenes/player/player.tscn")
		get_tree().change_scene_to_file("res://scenes/levels/level.tscn")
		current_stamina = max_stamina
		respawn = true
		update_stamina = true
	
