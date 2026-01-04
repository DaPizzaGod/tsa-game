extends PlayerParent

var jump_vel := -600.0

func _process(delta: float) -> void:
	# Apply Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Jump
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_vel
		
	# Left and Right
	
	var direction := Input.get_axis("left", "right")
	velocity.x = direction * speed
	
	# Move
	move_and_slide() 
