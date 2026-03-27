extends Level

func _ready() -> void:
	level_path = "res://scenes/levels/level_11.tscn"
	ready_code(1)
	ModeCalc.stetch_unlocked = true
	ModeCalc.spring_unlocked = true
	ModeCalc.slide_unlocked = true


func _process(_delta: float) -> void:
	
	process_code()
