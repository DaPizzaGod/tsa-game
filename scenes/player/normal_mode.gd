extends PlayerParent

var jump_vel := -600.0
var direction: float
var running := false
var running_bonus := 400.0


func _process(delta: float) -> void:
	# Apply Gravity
	if not is_on_floor():
		velocity.y += get_grav(velocity) * delta
	
	# Jump
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_vel
		
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
		subtract_stamina(1)
		if !Input.is_action_pressed("shoot"):
			max_speed -= running_bonus
			print("not running")
			running = false
	
	# Move
	move_and_slide() 

	

func run():
	if !Input.is_action_pressed("shoot"):
		return
	
	
	await get_tree().create_timer(0.5).timeout
	if !Input.is_action_pressed("shoot"):
		return
	
	print("running")
	max_speed += running_bonus
	running = true

	
	
		
