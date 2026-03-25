extends Node


@onready var text_box_scene = preload("res://scenes/ui/text_box.tscn")

var dialogue_lines : Array[String] = []
var current_line_index = 0

var text_box
var text_box_position : Vector2

var is_dialoge_active := false
var can_advance_line := false

func start_dialogue(position: Vector2, lines: Array[String]):
	if is_dialoge_active:
		return
		
	dialogue_lines = lines
	text_box_position = position
	_show_text_box()
	
	is_dialoge_active = true
	
func _show_text_box():
	text_box = text_box_scene.instantiate()
	text_box.finished_displaying.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position
	text_box.display_text(dialogue_lines[current_line_index])
	can_advance_line = false
	
	
func _on_text_box_finished_displaying():
	can_advance_line = true
	
	
func _unhandled_input(event: InputEvent) -> void:
	
	if(
		event.is_action_pressed("shoot") and 
		is_dialoge_active and
		can_advance_line
	):
		print("input")
		text_box.queue_free()
		
		current_line_index += 1
		if current_line_index >= dialogue_lines.size():
			is_dialoge_active = false
			current_line_index = 0
			return
			
		_show_text_box()
