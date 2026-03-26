extends PlayerParent

var jump_vel:= -1100.0
var dir
var can_jump:= true
var jumping_grav := 200.0
var gliding := false
var collision

func _physics_process(delta: float) -> void:
	queue_redraw()
	update_player_pos()
	# Apply Gravity
	if not is_on_floor():
		if Input.is_action_pressed("secondary") and StaminaCalc.current_stamina >= 1 and not is_on_wall() and not is_on_ceiling() and not is_on_floor():
			gliding = true
			
		else:
			gliding = false
		velocity.y += get_grav(velocity, gliding) * delta
	
	throw_mode()
	if not throwing:
		
		dir = -(global_position.direction_to(get_global_mouse_position()))
		

		# gliding
		
		if gliding:

			subtract_stamina(1)
			velocity.x = min(velocity.x, max_speed - 50.0)
			$Sprite.modulate = Color.BLUE_VIOLET
		else:
			$Sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)
			
		# Jump on floor
		if is_on_floor() and Input.is_action_just_pressed("shoot") and not ModeCalc.check_mode and can_jump and StaminaCalc.current_stamina >= 4 and not gliding:
			velocity.y = jump_vel
			$JumpCooldown.start()
			can_jump = false
			subtract_stamina(4)
		
		if is_on_floor() or throwing:
			$Sprite2D/Arrow.hide()
		elif not is_on_floor() and not throwing:
			$Sprite2D/Arrow.show()

		
		if not is_on_floor():
			
			if Input.is_action_just_pressed("shoot") and not ModeCalc.check_mode and can_jump and StaminaCalc.current_stamina >= 4 and not gliding:
				air_jump()
				$JumpCooldown.start()
				can_jump = false
				subtract_stamina(4)

		
			look_at(get_global_mouse_position())
		else:
			gliding = false
			
			

		#Move and Bounce
	move_and_slide()
	collision = move_and_collide(velocity * delta, true)
	if collision and not gliding:
		gliding = false
		var bounce_vel = velocity * 0.6
		velocity = bounce_vel.bounce(collision.get_normal())
	
	
	

func air_jump():
	velocity = jump_vel * dir

	
func _on_jump_cooldown_timeout() -> void:
	can_jump = true
	
	
