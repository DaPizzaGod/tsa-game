extends  CharacterBody2D
class_name PlayerParent

func _ready() -> void:
	add_to_group("Players")

var speed := 400.0
var gravity := 1200.0
