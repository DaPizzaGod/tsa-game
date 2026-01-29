extends  CharacterBody2D
class_name PlayerParent
var max_speed := 600.0
var gravity := 1200.0
var acc = 1.0
var can_sub_stamina:= true
var fall_gravity:= gravity + 600

func _ready() -> void:
	add_to_group("Players")

func subtract_stamina(amount):
	if can_sub_stamina:
		StaminaCalc.current_stamina -= amount
		StaminaCalc.update_stamina = true
		can_sub_stamina = false
		var sub_stamina_cooldown = Timer.new()
		add_child(sub_stamina_cooldown)
		sub_stamina_cooldown.wait_time = .75
		sub_stamina_cooldown.one_shot = true
		sub_stamina_cooldown.timeout.connect(_on_sub_stamina_cooldown_timeout)
		sub_stamina_cooldown.start()
		
func _on_sub_stamina_cooldown_timeout():
	can_sub_stamina = true
	
func get_grav(vel: Vector2):
	if vel.y < 0:
		return gravity
	return fall_gravity
