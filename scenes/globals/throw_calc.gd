extends Node
var picked_up := false
var player_pos: Vector2
var lantern_holding
var throwing:= false

func throw_lantern(throw_force, forward_dir):
	throwing = true
	lantern_holding.global_position = player_pos
	lantern_holding.linear_velocity = throw_force * forward_dir
	print("threw")
	throwing = false
	#lantern_holding = null
