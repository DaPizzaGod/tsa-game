extends Level

func _ready() -> void:
	level_path = "res://scenes/levels/slide_shrine.tscn"
	ready_code(1)
	ModeCalc.stetch_unlocked = true
	ModeCalc.spring_unlocked = true


func _process(_delta: float) -> void:
	
	process_code()
