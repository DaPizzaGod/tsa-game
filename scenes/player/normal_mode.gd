extends PlayerParent

var jump_vel := -600.0
var direction: float





func _process(delta: float) -> void:
	# Apply Gravity
	if not is_on_floor():
		velocity.y += get_grav(velocity) * delta
	
	# Jump
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_vel
		
	if Input.is_action_just_released("jump") and velocity.y < 0: 
		print("falling")
		velocity.y = jump_vel / 4
	# Left and Right
	
	if Input.is_action_pressed("right"):
		direction = min(direction + acc, max_speed)
	elif Input.is_action_pressed("left"):
		direction = max(direction - acc, -max_speed)
		
	else:
		direction = move_toward(direction, 0.0, acc)

		
	
	
	
	velocity.x = direction
	
	# Move
	move_and_slide() 
