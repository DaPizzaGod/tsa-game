extends Node2D
	


var new_player
var normal: PackedScene = preload("res://scenes/player/normal_mode.tscn")
var stretch: PackedScene = preload("res://scenes/player/stretch_mode.tscn")
var spring: PackedScene = preload("res://scenes/player/spring_mode.tscn")


func _ready() -> void:
	$PlayerNode.add_child(normal.instantiate())

	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("switch mode"):
		if ModeCalc.mode == "normal":
			swap_player(normal)
		elif ModeCalc.mode == "stretch":
			swap_player(stretch)
		elif ModeCalc.mode == "spring":
			swap_player(spring)
			
	if ModeCalc.menu:
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
	if new_player.has_meta("tween"):
		new_player.get_meta("tween").kill()
	
	var tween := create_tween()
	tween.tween_property(new_player, "velocity:x", 0.0, 1.0).set_ease(Tween.EASE_IN_OUT)
	
	
func _on_shoot_hand():
	print("shoot")
