extends RigidBody2D
var picked_up := false


func _on_pick_up_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		picked_up = true
		
func _physics_process(_delta: float) -> void:
	if picked_up:
		position = ModeCalc.player_pos
