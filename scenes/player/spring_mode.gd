extends PlayerParent

func _process(delta: float) -> void:
	# Apply Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
