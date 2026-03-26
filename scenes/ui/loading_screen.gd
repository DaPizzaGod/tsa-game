extends Control

@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar

var loading_speed := 1.0
func _physics_process(_delta: float) -> void:
	texture_progress_bar.value += loading_speed
	if texture_progress_bar.value >= 100:
		texture_progress_bar.value = 0
