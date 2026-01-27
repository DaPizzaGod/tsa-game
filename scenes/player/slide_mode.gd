extends PlayerParent

var ceiling_sticky:= false
var wall_sticky:= false
var shrink:= 1

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
	
	if is_on_wall() or is_on_ceiling() or is_on_floor() and Input.is_action_just_pressed("other special action"):
		pass
		
	
