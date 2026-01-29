extends Node2D



func _on_collect_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		queue_free()
