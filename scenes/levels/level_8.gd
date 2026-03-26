extends Level

func _ready() -> void:
	level_path = "res://scenes/levels/level_8.tscn"
	ready_code(2)
	ModeCalc.stetch_unlocked = true
	ModeCalc.spring_unlocked = true


func _process(_delta: float) -> void:
	
	process_code()
