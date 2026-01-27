extends  CharacterBody2D
class_name PlayerParent

func _ready() -> void:
	add_to_group("Players")

var speed := 525.0
var gravity := 1200.0

func subtract_stamina(amount):
	StaminaCalc.current_stamina -= amount
