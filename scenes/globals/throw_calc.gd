extends Node
var picked_up := false
var player_pos: Vector2
var lantern_holding: RigidBody2D
var throwing:= false
var lantern_pos: Vector2
var has_lantern := false
var hand_lantern_attatched := false
var max_lanterns :int
var current_lanterns := 0
var blocked_hooks := []

func throw_lantern(throw_force, forward_dir):
	if has_lantern:
		throwing = true
		lantern_holding.global_position = player_pos
		lantern_holding.linear_velocity = throw_force * forward_dir

		await get_tree().create_timer(0.1).timeout

		throwing = false

	
func _physics_process(_delta: float) -> void:
	if typeof(lantern_holding) == 24:
		has_lantern = true
		lantern_pos = lantern_holding.position
	else:
		has_lantern = false
		
	if current_lanterns >= max_lanterns:
		#print("finished level") #update later to change level
		await get_tree().create_timer(1.0).timeout
		LevelCalc.finish_level.emit()
		print("signal")
		current_lanterns = 0
		
	if StaminaCalc.respawn:
		blocked_hooks = []
