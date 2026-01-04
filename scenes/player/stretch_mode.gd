extends PlayerParent
var current_hand :Node = null
var hand_scene :PackedScene= preload("res://scenes/projectiles/hand.tscn")
var launch_speed := 1500.0
@onready var arm: Line2D = $Arm


func _ready() -> void:
	$Hand.queue_free()


func _process(delta: float) -> void:
	# Apply Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	if current_hand:
		arm.visible = true
		arm.clear_points()
		arm.add_point(Vector2.ZERO)
		arm.add_point(current_hand.global_position - global_position)
	else:
		arm.visible = false
	# Shoot hand
	if Input.is_action_just_pressed("shoot") and current_hand == null:

		spawn_hand()
	
	# launch towards hand
	
	if Input.is_action_just_pressed("special action") and current_hand and current_hand.attatched:
		var dir = (current_hand.global_position - position).normalized()
		velocity = dir * launch_speed
		#current_hand.queue_free()
	
	# move
	move_and_slide()

	
func spawn_hand():
	var dir = (get_global_mouse_position() - position).normalized()
	var hand = hand_scene.instantiate()
	hand.position = global_position
	hand.direction = dir
	hand.rotation_degrees = rad_to_deg(dir.angle())
	get_parent().add_child(hand)
	
	current_hand = hand
	hand.tree_exited.connect(_on_hand_removed)
	
func _on_hand_removed():
	current_hand = null
	
