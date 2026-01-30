extends Node2D
class_name StaminaDamage
var damage:int
var can_damage:= true

func hit_player():
	if can_damage:
		StaminaCalc.current_stamina -= damage
		StaminaCalc.update_stamina = true
		can_damage = false
		$Sprite2D.modulate.a = .25
		await get_tree().create_timer(1).timeout
		$Sprite2D.modulate.a = 1
		can_damage = true
	
