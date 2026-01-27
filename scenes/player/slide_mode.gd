extends PlayerParent

var ceiling_sticky:= false
var wall_sticky:= false
var shrink:= 1
var in_level:= false
var wall_normal
var level_move_speed:= 350.0
var physics_initialized := false
var can_exit := false

func _process(delta: float) -> void:
	if !physics_initialized:
		move_and_slide()
		physics_initialized = true
		return
	
	if not in_level:
	
		
		# Make sticky
		if is_on_ceiling():
			ceiling_sticky = true
			velocity.y = min(velocity.y, 0)
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
		if is_on_floor() or ceiling_sticky:
			var direction := Input.get_axis("left", "right")
			velocity.x = direction * speed
		
		# Shrinking
		
		if Input.is_action_just_pressed("secondary"):
			shrink *= -1
			
		
		if shrink == -1:
			var tween:= create_tween()
			tween.set_parallel(true)
			tween.tween_property($Sprite2D, "scale", Vector2(0.05, 0.05), 0.2).set_ease(Tween.EASE_IN_OUT)
			tween.tween_property($CollisionShape2D, "scale", Vector2(0.05, 0.05), 0.2).set_ease(Tween.EASE_IN_OUT)
		else:
			var tween:= create_tween()
			tween.set_parallel(true)
			tween.tween_property($Sprite2D, "scale", Vector2(0.1, 0.1), 0.2).set_ease(Tween.EASE_IN_OUT)
			tween.tween_property($CollisionShape2D, "scale", Vector2(0.1, 0.1), 0.2).set_ease(Tween.EASE_IN_OUT)
	
	# Digging
	
	if is_on_floor() and Input.is_action_just_pressed("other special action"):
		go_inside_level()
			

		
	
	if in_level:
		var dir := Input.get_axis("left", "right")
		velocity.x = dir * level_move_speed
		
		if Input.is_action_just_pressed("other special action") and can_exit:
			exit_wall()


		
	move_and_slide()	

		
func go_inside_level():
	
	in_level = true
	can_exit = false
	var inside_cooldown := Timer.new()
	add_child(inside_cooldown)
	inside_cooldown.wait_time = 0.5
	inside_cooldown.timeout.connect(_on_inside_cooldown_timeout)
	inside_cooldown.one_shot = true
	inside_cooldown.start()
	collision_mask &= ~2 
	wall_normal = get_last_slide_collision().get_normal() 

	var max_exit_distance := 400  
	var step := 4                 
	var exit_distance := 0

	# Check how far we can move down without colliding
	while exit_distance < max_exit_distance:
		var check_position := global_position + Vector2(0, step)
		if test_move(global_transform, check_position + global_position):
			break  # Hit something, stop
		exit_distance += step
		global_position.y += step

	
		
func exit_wall():
	if not in_level:
		return

	var max_exit_distance := 400  # Maximum distance to move up
	var step := 4                 # How granular to check for space (smaller = more precise)
	var exit_distance := 0

	# Check how far we can move up without colliding
	while exit_distance < max_exit_distance:
		var check_position := global_position - Vector2(0, step)
		if test_move(global_transform, check_position - global_position):
			break  # Hit something, stop
		exit_distance += step
		global_position.y -= step

	# If we actually moved some distance, exit
	if exit_distance > 0:
		in_level = false
		collision_mask |= 2
		global_position += wall_normal * 6
		velocity *= 0.3


func _on_inside_cooldown_timeout():
	can_exit = true
