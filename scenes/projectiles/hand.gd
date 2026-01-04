extends Area2D

var player: Node = null
var speed := 2000.0
var direction:= Vector2.UP

var attatched := false

func _ready() -> void:
	$SelfDestruct.start()


func _process(delta: float) -> void:
	if not attatched:
		position += direction * speed * delta
		
	if player and player.launching:
		pass


func _on_self_destruct_timeout() -> void:
	queue_free()
	


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Level"):
		attatched = true
