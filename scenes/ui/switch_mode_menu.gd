extends Control

@onready var stretch_lock: Sprite2D = $StretchLock
@onready var spring_lock: Sprite2D = $SpringLock
@onready var slide_lock: Sprite2D = $SlideLock
@onready var stretch_button: Button = $StretchButton
@onready var spring_button: Button = $SpringButton
@onready var slide_button: Button = $SlideButton


func _ready() -> void:
	if !ModeCalc.stetch_unlocked:
		stretch_button.queue_free()
		stretch_lock.show()
	
		
	
	if !ModeCalc.spring_unlocked:
		spring_button.queue_free()
		spring_lock.show()
	
		
		
	if !ModeCalc.slide_unlocked:
		slide_button.queue_free()
		slide_lock.show()
	
		

func _on_normal_button_pressed() -> void:
	change_mode(0)


func _on_stretch_button_pressed() -> void:
	change_mode(1)

func _on_spring_button_pressed() -> void:
	change_mode(2)
func _on_slide_button_pressed() -> void:
	change_mode(3)
	
	
func change_mode(item):
	
	ModeCalc.mode = ModeCalc.modes[item]
	Engine.time_scale = 1
	ModeCalc.check_mode = true
	ModeCalc.menu_count -= 1

	queue_free()
	
