extends Area2D
var speed := 2000.0
var direction:= Vector2.UP

func _ready() -> void:
	$SelfDestruct.start()


func _process(delta: float) -> void:
	position += direction * speed * delta


func _on_self_destruct_timeout() -> void:
	queue_free()
	


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Level"):
		speed = 0
