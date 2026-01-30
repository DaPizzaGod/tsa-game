extends StaminaDamage

var going_up := true
var spacing := 225
var tween: Tween
var base_y: float

func _ready() -> void:
	damage = 5
	base_y = position.y

	move()

func move():
	while is_inside_tree():
		tween = create_tween()
		
		if going_up:

			tween.tween_property(self, "position:y", base_y - spacing, 0.75).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
		elif !going_up:

			tween.tween_property(self, "position:y", base_y + spacing, 0.75).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
		
		await  tween.finished
		going_up = !going_up


func _on_damage_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		hit_player()
	else:
		print("denied")
