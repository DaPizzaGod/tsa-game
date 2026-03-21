extends Node2D

var stamina_add_val : int
var going_up := true
var spacing := 50
var tween: Tween
var base_y: float

	

func move():
	while is_inside_tree():
		tween = create_tween()
		
		if going_up:

			tween.tween_property(self, "position:y", base_y - spacing, 0.75).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
		elif !going_up:

			tween.tween_property(self, "position:y", base_y + spacing, 0.75).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
		
		await  tween.finished
		going_up = !going_up



func _ready() -> void:
	stamina_add_val = randi_range(3, 6)
	base_y = position.y

	move()


func _on_collect_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		StaminaCalc.current_stamina += stamina_add_val
		StaminaCalc.check_if_over = true
		$Sprite2D.hide()
		$CPUParticles2D.emitting = true
		await get_tree().create_timer(0.7).timeout
		queue_free()
