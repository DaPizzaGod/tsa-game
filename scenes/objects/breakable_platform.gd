extends StaticBody2D

var time = 1
@export var shake_time : float

func _ready() -> void:
	set_process(false)


func _process(_delta: float) -> void:
	time += 1
	$Sprite2D.position += Vector2(0,sin(time) * 5)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		set_process(true)
		$Timer.start(shake_time)


func _on_timer_timeout() -> void:
	if is_processing():
		set_process(false)
		$CPUParticles2D.emitting = true
		$Sprite2D.queue_free()
		$CollisionShape2D.queue_free()
		$Area2D.queue_free()
		$Timer.start(1.0)
	else:
		queue_free()
