extends Node2D
	


var new_player
var new_transition
var normal: PackedScene = preload("res://scenes/player/normal_mode.tscn")
var stretch: PackedScene = preload("res://scenes/player/stretch_mode.tscn")
var spring: PackedScene = preload("res://scenes/player/spring_mode.tscn")
var slide: PackedScene = preload("res://scenes/player/slide_mode.tscn")
@onready var menus = $Menus
var transition_layer: PackedScene = preload("res://scenes/globals/transition_layer.tscn")


func _ready() -> void:
	$PlayerNode.add_child(normal.instantiate())
	swap_player(normal, $SpawnPoint.global_position)
	ModeCalc.menu_root = menus



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
		$PlayerUI.hide()
		ModeCalc.reset_kill = true
		
		swap_player(normal, $SpawnPoint.global_position)
		StaminaCalc.respawn = false
		new_transition = transition_layer.instantiate()
		$TransitionParent.add_child(new_transition)
		new_transition.fade()
		var kill_wait := Timer.new()
		kill_wait.one_shot = true
		kill_wait.wait_time = 1.5
		add_child(kill_wait)
		kill_wait.timeout.connect(_on_kill_wait_timeout)
		kill_wait.start()

func _on_kill_wait_timeout():
	$PlayerUI.show()
	new_transition.queue_free()
		
func swap_player(scene: PackedScene, pos = null):
	var old_player = get_tree().get_nodes_in_group("Players")[0]
	var old_pos = old_player.global_position
	var old_vel = old_player.velocity
	
	old_player.queue_free()
	
	new_player = scene.instantiate()
	$PlayerNode.add_child(new_player)
	
	if pos != null:
		new_player.global_position = pos
	else:
		new_player.global_position = old_pos
	new_player.velocity = old_vel
	

	
	#Slow down
	
	var tween := create_tween()
	tween.tween_property(new_player, "velocity:x", 0.0, 1.0).set_ease(Tween.EASE_IN_OUT)
	
	
func _on_shoot_hand():
	print("shoot")
