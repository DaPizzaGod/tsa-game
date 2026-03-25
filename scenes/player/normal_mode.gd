extends PlayerParent

var jump_vel := -900.0
var direction: float
var running := false
var running_bonus := 400.0
var jump_buffer := false
var jump_available := true
var coyote_time := 0.1
@onready var animation_player: AnimationPlayer = $Sprite/AnimationPlayer
@onready var sprite: Node2D = $Sprite
@onready var right_foot: Sprite2D = $Sprite/Body/RightFoot
@onready var left_foot: Sprite2D = $Sprite/Body/LeftFoot





func _physics_process(delta: float) -> void:
	
	
	queue_redraw()
	update_player_pos($Sprite/Body/LeftHand.global_position)
	var acc = accel * delta
	# Apply Gravity
	if not is_on_floor():
		if jump_available:
			get_tree().create_timer(coyote_time).timeout.connect(_on_coyote_timeout)
		
		velocity.y += get_grav(velocity) * delta
		if Input.is_action_just_pressed("jump"):
			jump_buffer = true
			await get_tree().create_timer(0.3).timeout
			jump_buffer = false
	else:
		jump_available = true
	
	throw_mode()
	if !in_dialogue:
		animation_player.play("idle")
		return
	if throwing:
		
		if get_global_mouse_position() < global_position:
			
			sprite.scale.x = -1
		else:
			
			sprite.scale.x = 1
		
		animation_player.play("throw")
	
	if not throwing:
		

		
		# Jump
		
		if jump_available:
			if Input.is_action_just_pressed("jump") or jump_buffer:
				animation_player.play("jump")
				velocity.y = jump_vel
				jump_buffer = false
				jump_available = false
			
			
		if Input.is_action_just_released("jump") and velocity.y < 0: 
			velocity.y = jump_vel / 4
		# Left and Right
		
		if running:
			animation_player.speed_scale = 2
		else:
			animation_player.speed_scale = 1
		
		if Input.is_action_pressed("right"):
			sprite.scale.x = 1
			direction = min(direction + acc, max_speed)
			if is_on_floor():
				animation_player.play("walking")
		elif Input.is_action_pressed("left"):
			sprite.scale.x = -1

			direction = max(direction - acc, -max_speed)
			if is_on_floor():
				animation_player.play("walking")
		else:
			direction = move_toward(direction, 0.0, acc)
			if is_on_floor():
				animation_player.play("idle")


		velocity.x = direction
		
		if not is_on_floor():
			animation_player.play("jump")
		
		if Input.is_action_just_pressed("run"):
			run()

		if running:
			$Sprite2D.modulate = Color.AQUAMARINE
			subtract_stamina(1)

			if !Input.is_action_pressed("run"):
				max_speed -= running_bonus
				running = false
		else:
			$Sprite2D.modulate = Color.WHITE
		# Move
	move_and_slide() 

	

func run():
	if !Input.is_action_pressed("run"):
		return
	
	
	await get_tree().create_timer(0.5).timeout
	if !Input.is_action_pressed("run"):
		return
	
	max_speed += running_bonus
	running = true

func _on_coyote_timeout():
	jump_available = false
	
	
		
