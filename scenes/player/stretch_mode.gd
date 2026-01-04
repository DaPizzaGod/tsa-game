extends PlayerParent
var current_hand :Node = null
var hand_scene :PackedScene= preload("res://scenes/projectiles/hand.tscn")
var launch_speed := 1500.0
@onready var arm: Line2D = $Arm
var launching := false
var swinging := false
var stop_distance := 2.0

func _ready() -> void:
	$Hand.queue_free()


func _process(delta: float) -> void:
	# Apply Gravity
	if not launching and not is_on_floor():
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
		launching = true
		
	if Input.is_action_just_pressed("other special action") and current_hand and current_hand.attatched:
		swinging = true
		
	if launching and current_hand:
		move_toward_hand()
	
	if swinging and current_hand:
		swing_toward_hand()
	
	# move
	move_and_slide()

	
func spawn_hand():
	var dir = (get_global_mouse_position() - position).normalized()
	var hand = hand_scene.instantiate()
	hand.player = self
	hand.position = global_position
	hand.direction = dir
	hand.rotation_degrees = rad_to_deg(dir.angle())
	get_parent().add_child(hand)
	
	current_hand = hand
	hand.tree_exited.connect(_on_hand_removed)
	
func _on_hand_removed():
	current_hand = null
	
func move_toward_hand():
	var to_hand = current_hand.global_position - global_position
	var distance = to_hand.length()
	
	if distance < stop_distance:
		launching = false
		velocity = Vector2.ZERO
		current_hand.queue_free()
		return
	var dir = to_hand.normalized()
	velocity = dir * launch_speed
