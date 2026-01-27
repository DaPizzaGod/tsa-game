extends  CharacterBody2D
class_name PlayerParent
var speed := 525.0
var gravity := 1200.0
var can_sub_stamina:= true

func _ready() -> void:
	add_to_group("Players")

func subtract_stamina(amount):
	if can_sub_stamina:
		StaminaCalc.current_stamina -= amount
		StaminaCalc.update_stamina = true
		print(StaminaCalc.current_stamina)
		can_sub_stamina = false
		var sub_stamina_cooldown = Timer.new()
		add_child(sub_stamina_cooldown)
		sub_stamina_cooldown.wait_time = .5
		sub_stamina_cooldown.one_shot = true
		sub_stamina_cooldown.timeout.connect(_on_sub_stamina_cooldown_timeout)
		sub_stamina_cooldown.start()
	else:
		push_error("denied")
		
func _on_sub_stamina_cooldown_timeout():
	can_sub_stamina = true
