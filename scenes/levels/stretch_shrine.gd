extends Level

func _ready() -> void:
	level_path = "res://scenes/levels/stretch_shrine.tscn"
	ready_code(1)


func _process(_delta: float) -> void:
	
	process_code()
