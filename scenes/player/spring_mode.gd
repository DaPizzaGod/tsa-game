extends PlayerParent

var jump_vel:= -1100.0
var dir
var dir_radians
var can_jump:= true

func _process(delta: float) -> void:
	dir = (global_position.direction_to(get_global_mouse_position()))
	dir_radians = dir.angle()
	# Apply Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Jump on floor
	if is_on_floor() and Input.is_action_just_pressed("shoot") and not ModeCalc.check_mode and can_jump:
		velocity.y = jump_vel
		$JumpCooldown.start()
		can_jump = false
	
	if not is_on_floor():
		
		if Input.is_action_just_pressed("shoot") and not ModeCalc.check_mode and can_jump:
			air_jump()
			$JumpCooldown.start()
			can_jump = false

	
		look_at(get_global_mouse_position())
		
		#rotation_degrees += 180
	# Move
	move_and_slide()

func air_jump():
	velocity.x = -dir.x * jump_vel
	velocity.y = -dir.y * jump_vel


func _on_jump_cooldown_timeout() -> void:
	can_jump = true
	
