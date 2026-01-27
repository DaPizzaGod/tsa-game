extends Node

var max_stamina:= 30
var current_stamina: int
var update_stamina:= false

func _ready() -> void:
	current_stamina = max_stamina
