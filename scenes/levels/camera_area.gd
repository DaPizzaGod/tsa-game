## camera_area.gd :: defines camera restrictions for a zone
class_name CameraArea extends Node2D

@export var jurisdiction: Polygon2D
@export var boundary: Polygon2D

var _jurisdiction_aabb: Rect2


func _ready() -> void:
	# Precompute the AABB
	_precompute_aabb()


func contains_point(point: Vector2) -> bool:
	# Quick rejection test using AABB
	if not jurisdiction or not _jurisdiction_aabb.has_point(point):
		return false

	# Slower polygon containment test
	var world_points := _get_world_polygon(jurisdiction)
	return Geometry2D.is_point_in_polygon(point, world_points)


func get_bound_position(desired: Vector2) -> Vector2:
	# Convert to world coordinates
	var world_points := _get_world_polygon(boundary)
	if Geometry2D.is_point_in_polygon(desired, world_points):
		return desired

	# Find closest point on boundary polygon
	var closest := world_points[0]
	var min_dist_sq := desired.distance_squared_to(closest)

	# Check against each segment (i, i+1)
	for i in world_points.size():
		var a := world_points[i]
		var b := world_points[(i + 1) % world_points.size()]
		var candidate := Geometry2D.get_closest_point_to_segment(desired, a, b)
		var dist_sq := desired.distance_squared_to(candidate)
		if dist_sq < min_dist_sq:
			min_dist_sq = dist_sq
			closest = candidate

	return closest


func _precompute_aabb() -> void:
	# Expand Rect2 to fit all polygon points
	var world_points := _get_world_polygon(jurisdiction)
	_jurisdiction_aabb = Rect2(world_points[0], Vector2.ZERO)
	for point in world_points:
		_jurisdiction_aabb = _jurisdiction_aabb.expand(point)


func _get_world_polygon(poly: Polygon2D) -> PackedVector2Array:
	# Helpers to get polygon points in world space
	var pts := poly.polygon
	var world := PackedVector2Array()
	world.resize(pts.size())
	for i in pts.size():
		world[i] = poly.to_global(pts[i])
	return world
