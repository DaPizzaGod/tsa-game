extends  CharacterBody2D
class_name PlayerParent
var max_speed := 600.0
var gravity := 1200.0
var accel := 3000.0
var can_sub_stamina:= true
var fall_gravity:= gravity + 800
var glide_gravity:= gravity - 800
var throwing:= false
var throw_force := 1500.0


func _draw() -> void:
	if throwing:
		update_trajectory()

func get_forward_direction() -> Vector2:

	return global_position.direction_to(get_global_mouse_position())
	

func _ready() -> void:
	add_to_group("Players")


func subtract_stamina(amount):
	if can_sub_stamina:
		StaminaCalc.current_stamina -= amount
		StaminaCalc.update_stamina = true
		can_sub_stamina = false
		var sub_stamina_cooldown = Timer.new()
		add_child(sub_stamina_cooldown)
		sub_stamina_cooldown.wait_time = .75
		sub_stamina_cooldown.one_shot = true
		sub_stamina_cooldown.timeout.connect(_on_sub_stamina_cooldown_timeout)
		sub_stamina_cooldown.start()
		
func _on_sub_stamina_cooldown_timeout():
	can_sub_stamina = true
	
func get_grav(vel: Vector2, gliding=false):
	if gliding:
		return glide_gravity
	if vel.y < 0:
		return gravity
	return fall_gravity


func update_player_pos():
	ThrowCalc.player_pos = position

func throw_mode():
	if ThrowCalc.picked_up:
		if Input.is_action_just_pressed("throw mode"):
			if not throwing:
				throwing = true
			else:
				throwing = false

		
		if not throwing:
			return
		rotation_degrees = 0.0
		
		if Input.is_action_just_pressed("shoot"):
			ThrowCalc.throw_lantern(throw_force, get_forward_direction())
			await get_tree().create_timer(0.1).timeout
			throwing = false
			subtract_stamina(2)
		
func draw_line_global(pointA: Vector2, pointB: Vector2, color, width:int = -1) -> void:
	var local_offset := pointA - global_position
	var pointB_local := pointB - global_position
	draw_line(local_offset, pointB_local, color, width)

func update_trajectory():
	var vel := throw_force * get_forward_direction()
	var line_start := global_position
	var line_end:Vector2
	var drag:float = ProjectSettings.get_setting("physics/2d/default_linear_damp")
	var timestep := 0.02
	var colors := [Color.CRIMSON, Color(0.0, 0.0, 0.0, 0.0)]
	
	for i:int in 45:
		vel.y += gravity * timestep
		line_end = line_start + (vel * timestep)
		vel = vel * clampf(1.0 - drag * timestep, 0, 1)

		var ray = raycast_query2d(line_start, line_end)
		
		if not ray.is_empty():
			break
	
		draw_line_global(line_start, line_end, colors[i%2])
		line_start = line_end

func raycast_query2d(pointA:Vector2, pointB:Vector2):
	var space_state := get_world_2d().direct_space_state
	var query := PhysicsRayQueryParameters2D.create(pointA, pointB, 2)
	var result := space_state.intersect_ray(query)
	
	if result:
		return result
	else:
		return {}
	
