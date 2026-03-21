extends StaminaDamage

func _ready() -> void:
	damage = StaminaCalc.max_stamina
	
	


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		hit_player(false)
