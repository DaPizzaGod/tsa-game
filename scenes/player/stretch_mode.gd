extends PlayerParent
var current_hand :Node = null
var hand_scene :PackedScene= preload("res://scenes/projectiles/hand.tscn")

func _ready() -> void:
	$Hand.queue_free()


func _process(delta: float) -> void:
	# Apply Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("shoot"):

		if current_hand == null:
			spawn_hand()
	
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
	
