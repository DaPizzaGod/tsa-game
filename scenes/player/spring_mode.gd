extends PlayerParent

var jump_vel:= -1100.0
var dir
var can_jump:= true
var jumping_grav := 200.0



func _physics_process(delta: float) -> void:
	dir = -(global_position.direction_to(get_global_mouse_position()))


	# Apply Gravity
		
	
	if not is_on_floor():
		velocity.y += get_grav(velocity) * delta
		
	# Jump on floor
	if is_on_floor() and Input.is_action_just_pressed("shoot") and not ModeCalc.check_mode and can_jump and StaminaCalc.current_stamina >= 4:
		velocity.y = jump_vel
		$JumpCooldown.start()
		can_jump = false
		subtract_stamina(4)
	
	if is_on_floor():
		$Sprite2D/Arrow.hide()
	else:
		$Sprite2D/Arrow.show()

	
	if not is_on_floor():
		
		if Input.is_action_just_pressed("shoot") and not ModeCalc.check_mode and can_jump and StaminaCalc.current_stamina >= 4:
			air_jump()
			$JumpCooldown.start()
			can_jump = false
			subtract_stamina(4)

	
		look_at(get_global_mouse_position())
		
		

	#Move and Bounce
	move_and_slide()
	var collision := move_and_collide(velocity * delta, true)
	if collision:
		var bounce_vel = velocity * 0.6
		velocity = bounce_vel.bounce(collision.get_normal())
	
	
	

func air_jump():
	velocity = jump_vel * dir

	
func _on_jump_cooldown_timeout() -> void:
	can_jump = true
	
	
