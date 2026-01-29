extends Node2D

var stamina_add_val : int

func _ready() -> void:
	stamina_add_val = randi_range(3, 6)
	print(stamina_add_val)


func _on_collect_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		StaminaCalc.current_stamina += stamina_add_val
		StaminaCalc.check_if_over = true
		queue_free()
