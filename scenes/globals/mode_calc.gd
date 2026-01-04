extends Node

var mode := "normal"
var max_count := 2

var modes := ["normal", "stretch", "spring"]
var count := 0

func _process(_delta: float) -> void:
	# When shift is pressed
	if Input.is_action_just_pressed("switch mode"):
		if count != max_count:
			count += 1
		else:
			count = 0
		mode = modes[count]
		print(mode)
