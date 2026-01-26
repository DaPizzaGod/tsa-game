extends PlayerParent

var jump_vel:= -800.0
var dir
var dir_radians
func _process(delta: float) -> void:
	dir = (global_position.direction_to(get_global_mouse_position()))
	dir_radians = dir.angle()
	# Apply Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Jump on floor
	if is_on_floor() and Input.is_action_just_pressed("shoot") and not ModeCalc.check_mode:
		velocity.y = jump_vel
	
	if not is_on_floor():
		
		if Input.is_action_just_pressed("shoot") and not ModeCalc.check_mode:
			air_jump()

	
		look_at(dir)
		rotation_degrees += 180
	# Move
	move_and_slide()

func air_jump():
	velocity.x = -dir.x * jump_vel
	velocity.y = -dir.y * jump_vel
