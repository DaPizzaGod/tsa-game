extends RigidBody2D
var picked_up := false
var pick_up_animation := false



func _on_pick_up_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		pick_up_animation = true
	#elif body.is_in_group("Level"):
		#picked_up = false
		
func _physics_process(_delta: float) -> void:
	if pick_up_animation:
		var tween = create_tween()
		tween.tween_property(self, "position", ThrowCalc.player_pos, 0.1).set_trans(Tween.TRANS_BOUNCE)
		pick_up_animation = false
		await tween.finished
		picked_up = true
	
	if picked_up:
		position = ThrowCalc.player_pos
