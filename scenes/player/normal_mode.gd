extends PlayerParent

var jump_vel := -600.0
var direction: float
var running := false
var running_bonus := 400.0
var jump_buffer := false

func _physics_process(delta: float) -> void:
	var acc = accel * delta
	# Apply Gravity
	if not is_on_floor():
		velocity.y += get_grav(velocity) * delta
		if Input.is_action_just_pressed("jump"):
			jump_buffer = true

	
	# Jump
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump") or jump_buffer:
			velocity.y = jump_vel
			jump_buffer = false
		
		
	if Input.is_action_just_released("jump") and velocity.y < 0: 
		velocity.y = jump_vel / 4
	# Left and Right
	
	if Input.is_action_pressed("right"):
		direction = min(direction + acc, max_speed)
	elif Input.is_action_pressed("left"):
		direction = max(direction - acc, -max_speed)
		
	else:
		direction = move_toward(direction, 0.0, acc)

	velocity.x = direction
	
	if Input.is_action_just_pressed("shoot"):
		run()

	if running:
		$Sprite2D.modulate = Color.AQUAMARINE
		subtract_stamina(1)
		if !Input.is_action_pressed("shoot"):
			max_speed -= running_bonus
			running = false
	else:
		$Sprite2D.modulate = Color.WHITE
	# Move
	move_and_slide() 

	

func run():
	if !Input.is_action_pressed("shoot"):
		return
	
	
	await get_tree().create_timer(0.5).timeout
	if !Input.is_action_pressed("shoot"):
		return
	
	max_speed += running_bonus
	running = true

	
	
		
