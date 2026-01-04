extends PlayerParent

var jump_vel:= -800.0

func _process(delta: float) -> void:
	# Apply Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Jump on floor
	if is_on_floor() and Input.is_action_just_pressed("shoot"):
		velocity.y = jump_vel
	
	if not is_on_floor():
		look_at(get_global_mouse_position())
		if Input.is_action_just_pressed("shoot"):
			var dir = (get_global_mouse_position() - position)
			air_jump(dir)
		
	# Move

	move_and_slide()

func air_jump(dir):
	var velx = dir.x 
	var vely = dir.y
	velocity.x = velx
	velocity.y = vely
