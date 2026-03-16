extends Node2D
	


var new_player
var new_transition
var normal: PackedScene = preload("res://scenes/player/normal_mode.tscn")
var stretch: PackedScene = preload("res://scenes/player/stretch_mode.tscn")
var spring: PackedScene = preload("res://scenes/player/spring_mode.tscn")
var slide: PackedScene = preload("res://scenes/player/slide_mode.tscn")
@onready var menus = $Menus
var transition_layer: PackedScene = preload("res://scenes/globals/transition_layer.tscn")
var transitions:= 0

func _ready() -> void:
	$PlayerNode.add_child(normal.instantiate())
	swap_player(normal, $SpawnPoint.global_position)
	ModeCalc.menu_root = menus
	ThrowCalc.max_lanterns = 1



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
		
	
	if StaminaCalc.respawn:
		if transitions == 0:
			transitions += 1
		else:
			return
		
		$PlayerUI.hide()

		for i in $TransitionParent.get_children():
			i.queue_free()
		
		
		swap_player(normal, $SpawnPoint.global_position)
		new_transition = transition_layer.instantiate()
		$TransitionParent.add_child(new_transition)
		new_transition.fade()
		await new_transition.animation_player.animation_finished
		StaminaCalc.respawn = false
		StaminaCalc.update_stamina = true
		$PlayerUI.show()
		new_transition.queue_free()


		
func swap_player(scene: PackedScene, pos = null):
	
	ModeCalc.swapping = true
	var old_player = get_tree().get_nodes_in_group("Players")[0]
	var old_pos = old_player.global_position
	var old_vel = old_player.velocity
	var old_cam_pos = old_player.player_camera.global_position
	old_player.queue_free()
	
	new_player = scene.instantiate()
	
	$PlayerNode.add_child(new_player)
	
	if pos != null:
		new_player.global_position = pos
	else:
		new_player.global_position = old_pos
	new_player.velocity = old_vel
	
	
	ModeCalc.swapping = false
	#Slow down
	
	var tween := create_tween()
	tween.tween_property(new_player, "velocity:x", 0.0, 1.0).set_ease(Tween.EASE_IN_OUT)
	new_player.player_camera.global_position = old_cam_pos
	
	
