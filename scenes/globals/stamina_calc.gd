extends Node

var max_stamina:= 30
var current_stamina: int
var update_stamina:= false
var respawn:= false

func _ready() -> void:
	current_stamina = max_stamina

func _process(_delta: float) -> void:
	
	
	if current_stamina <= 0:
		current_stamina = max_stamina
		respawn = true
		update_stamina = true
