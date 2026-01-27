extends PlayerParent

var ceiling_sticky:= false
var wall_sticky:= false

func _process(delta: float) -> void:
	# move
	move_and_slide()
	
	# Make sticky
	if is_on_ceiling():
		ceiling_sticky = true
	else:
		ceiling_sticky = false
	
	if is_on_wall():
		wall_sticky = true
		var direction := Input.get_axis("jump", "down")
		velocity.y = direction * speed
	else:
		wall_sticky = false
	
	# Gravity

	if not is_on_floor() and not ceiling_sticky and not wall_sticky:
		velocity.y += gravity * delta

		
	# Side to side movement
	if is_on_floor() or is_on_ceiling():
		var direction := Input.get_axis("left", "right")
		velocity.x = direction * speed
		
	
	
