extends PlayerParent

var ceiling_sticky:= false
var wall_sticky:= false
var shrink:= 1
var ghost_mode:= false
var wall_normal
var ghost_move_speed:= max_speed - 100.0
var can_exit := false
var direction := 0.0
var wall_direction := 0.0

func _ready() -> void:
	$CanExitChecker.monitoring = true
	$CanExitChecker/CollisionShape2D.disabled = false

func _process(delta: float) -> void:
	
	
	if not ghost_mode:
		# Gravity
		if not is_on_floor() and not ceiling_sticky and not wall_sticky:
			velocity.y += gravity * delta
		
		# Make sticky
		if is_on_ceiling():
			ceiling_sticky = true
			velocity.y = min(velocity.y, 0)
		else:
			ceiling_sticky = false
		
		if is_on_wall():
			wall_sticky = true
			if Input.is_action_pressed("down"):
				wall_direction = min(direction + acc, max_speed)
			elif Input.is_action_pressed("jump"):
				wall_direction = max(direction - acc, -max_speed)
			else:
				pass
				#wall_direction = move_toward(direction, 0.0, acc)
			velocity.y = wall_direction
		else:
			wall_sticky = false
			wall_direction = 0
		
	
		
		
		
			
		# Side to side movement
		if is_on_floor() or ceiling_sticky:
			if Input.is_action_pressed("right"):
				direction = min(direction + acc, max_speed)
			elif Input.is_action_pressed("left"):
				direction = max(direction - acc, -max_speed)
			else:
				direction = move_toward(direction, 0.0, acc)
		velocity.x = direction
		
		# Shrinking
		
		if Input.is_action_just_pressed("secondary") and StaminaCalc.current_stamina >= 2:
			shrink *= -1
			subtract_stamina(2)
			
			
		
		if shrink == -1:

			var tween:= create_tween()
			tween.set_parallel(true)
			tween.tween_property($Sprite2D, "scale", Vector2(0.05, 0.05), 0.2).set_ease(Tween.EASE_IN_OUT)
			tween.tween_property($CollisionShape2D, "scale", Vector2(0.05, 0.05), 0.2).set_ease(Tween.EASE_IN_OUT)
			tween.tween_property($CanExitChecker/CollisionShape2D, "scale", Vector2(0.5, 0.5), 0.2).set_ease(Tween.EASE_IN_OUT)
			
		else:

			var tween:= create_tween()
			tween.set_parallel(true)
			tween.tween_property($Sprite2D, "scale", Vector2(0.1, 0.1), 0.2).set_ease(Tween.EASE_IN_OUT)
			tween.tween_property($CollisionShape2D, "scale", Vector2(0.1, 0.1), 0.2).set_ease(Tween.EASE_IN_OUT)
			tween.tween_property($CanExitChecker/CollisionShape2D, "scale", Vector2(1, 1), 0.2).set_ease(Tween.EASE_IN_OUT)

	# Ghost
	
	if is_on_floor() and Input.is_action_just_pressed("other special action") and !wall_sticky and !ceiling_sticky and StaminaCalc.current_stamina >= 3:
		go_into_ghost()
		subtract_stamina(3)

	if ghost_mode:
		var dir := Input.get_axis("left", "right")
		velocity.x = dir * ghost_move_speed
		velocity.y = 0
		subtract_stamina(2)
		
		if Input.is_action_just_pressed("other special action") and can_exit:
			exit_ghost()
			

		
	move_and_slide()	

func go_into_ghost():
	can_exit = false
	$CollisionShape2D.disabled = true
	print("ghost")
	ghost_mode = true
	var can_exit_timer = Timer.new()
	add_child(can_exit_timer)
	can_exit_timer.one_shot = true
	can_exit_timer.wait_time = 0.1
	can_exit_timer.timeout.connect(_on_can_exit_timer_timeout)
	can_exit_timer.start()
	var tween:= create_tween()
	tween.tween_property($Sprite2D, "modulate:a", 0.5, 0.3).set_ease(Tween.EASE_IN_OUT)
	
func exit_ghost():
	await get_tree().physics_frame
	print($CanExitChecker.get_overlapping_bodies())

	if not $CanExitChecker.has_overlapping_bodies():
		var tween:= create_tween()
		tween.tween_property($Sprite2D, "modulate:a", 1, 0.3).set_ease(Tween.EASE_IN_OUT)
		print("not ghost")
		$CollisionShape2D.disabled = false
		ghost_mode = false
	else:
		print("overlapping something")

func _on_can_exit_timer_timeout():
	can_exit = true
