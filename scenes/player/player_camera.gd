extends Camera2D

var all_cam_areas := []
var current_area: CameraArea = null
var vertical_offset:= Vector2(0, -100)
var lookahead_strength := 200.0
var smoothing_speed:= 5.0
var lookahead_speed:= 2.0
var zoom_speed:= 3.0
var velocity_smooth: Vector2 = Vector2.ZERO
var lookahead_target: Vector2 = Vector2.ZERO
var lookahead_current: Vector2 = Vector2.ZERO
var previous_area: CameraArea = null
var transitioning: bool = false
var transition_tween: Tween = null
@onready var player := $".."

func _ready() -> void:

	all_cam_areas.assign(get_tree().get_nodes_in_group("CameraArea"))
	
func _physics_process(delta: float) -> void:
	find_current_area()
	
	var desired_position := get_desired_position(delta)
	await get_tree().create_timer(0.1).timeout
	var bound_position := current_area.get_bound_position(desired_position)
	
	var w: float = clamp(smoothing_speed * delta, 0.0, 1.0)
	global_position = global_position.lerp(bound_position, w)
	
	update_zoom(delta)

func get_lookahead(delta: float) -> Vector2:
	var w: float = clamp(lookahead_speed * delta, 0.0, 1.0)
	velocity_smooth = velocity_smooth.lerp(player.velocity, w)

	if velocity_smooth.length() > 10.0:
		lookahead_target = velocity_smooth.normalized() * lookahead_strength 
	lookahead_current = lookahead_current.lerp(lookahead_target, w) 

	return lookahead_current

func get_desired_position(delta: float) -> Vector2:

	return player.global_position + vertical_offset + get_lookahead(delta)

func find_current_area():
	if current_area and current_area.contains_point(player.global_position):
		return

	# Player left current area, find new area
	for area in all_cam_areas:
		if area.contains_point(player.global_position):
			current_area = area
			return

func update_zoom(delta: float) -> void:
	if current_area:
		var target_zoom := current_area.zoom_level
		zoom = zoom.lerp(Vector2.ONE * target_zoom, zoom_speed * delta)

func _enter_area(next: CameraArea) -> void:
	previous_area = current_area
	current_area = next

	if not previous_area:
		return

	var desired = player.global_position + vertical_offset + lookahead_current
	var new_bound_pos := current_area.get_bound_position(desired)
	var zoom_target := Vector2.ONE * current_area.zoom_level

	if transition_tween:
		transition_tween.kill()
	transitioning = true
	transition_tween = create_tween()
	transition_tween.set_trans(current_area.enter_trans).set_ease(current_area.enter_ease)
	transition_tween.tween_property(self, "global_position", new_bound_pos, current_area.enter_duration)
	transition_tween.parallel().tween_property(self, "zoom", zoom_target, current_area.enter_duration)
	transition_tween.finished.connect(func() -> void: transitioning = false)
