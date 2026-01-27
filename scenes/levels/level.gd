extends Node2D
	


var new_player
var normal: PackedScene = preload("res://scenes/player/normal_mode.tscn")
var stretch: PackedScene = preload("res://scenes/player/stretch_mode.tscn")
var spring: PackedScene = preload("res://scenes/player/spring_mode.tscn")
var slide: PackedScene = preload("res://scenes/player/slide_mode.tscn")


func _ready() -> void:
	$PlayerNode.add_child(normal.instantiate())
	swap_player(normal)


func _process(_delta: float) -> void:
	if ModeCalc.check_mode:
		if ModeCalc.mode == "normal":
			swap_player(normal)
		elif ModeCalc.mode == "stretch":
			swap_player(stretch)
		elif ModeCalc.mode == "spring":
			swap_player(spring)
		elif ModeCalc.mode == "slide":
			swap_player(slide)
			
		ModeCalc.check_mode = false
			
	# Move menu to player
	if ModeCalc.menu and typeof(new_player) == 24:
		ModeCalc.menu.position = new_player.global_position


		
func swap_player(scene: PackedScene):
	var old_player = get_tree().get_nodes_in_group("Players")[0]
	var old_pos = old_player.global_position
	var old_vel = old_player.velocity
	
	old_player.queue_free()
	
	new_player = scene.instantiate()
	$PlayerNode.add_child(new_player)
	new_player.global_position = old_pos
	new_player.velocity = old_vel
	

	
	#Slow down
	
	var tween := create_tween()
	tween.tween_property(new_player, "velocity:x", 0.0, 1.0).set_ease(Tween.EASE_IN_OUT)
	
	
func _on_shoot_hand():
	print("shoot")
