extends Area2D

var player: Node = null
var speed := 8000.0
var direction:= Vector2.UP

var attatched := false
var lantern_attatched := false

func _ready() -> void:
	$SelfDestruct.start()


func _process(delta: float) -> void:
	
	
	if not attatched:
		position += direction * speed * delta
		'''
		if lantern_attatched and not ModeCalc.stretch_moving:
			position = ThrowCalc.lantern_pos
	'''

func _on_self_destruct_timeout() -> void:
	queue_free()
	ThrowCalc.hand_lantern_attatched = false
	
 

func _on_body_entered(body: Node2D) -> void:

	if body.is_in_group("Level"):
		attatched = true
	
	if body.is_in_group("Lantern"):
		#lantern_attatched = true
		attatched = true
		ThrowCalc.hand_lantern_attatched = true
	else:
		ThrowCalc.hand_lantern_attatched = false
