extends CanvasLayer

@onready var animation_player := $AnimationPlayer

func _ready() -> void:
	$ColorRect.modulate = Color(0,0,0,0)

func fade():
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	animation_player.play("fade_out_black")
	await animation_player.animation_finished
