extends Node2D

const lines: Array[String] = [
	"I am a slippery fellow, always causing fear of what to come...", 
	"But, but, you handled the levels so perfectly!",
	"It's almost like you're clearing my anxiety?!", 
	"It can't be that, no, no...",
	"I don't know what, but you seem important. Take my gift and succeed in your journey"
]
@onready var area_2d: Area2D = $Area2D
@onready var marker_2d: Marker2D = $Marker2D
var started_dialogue:= false

func _process(_delta: float) -> void:
	if area_2d.get_overlapping_bodies().size() > 0 and not started_dialogue:
		started_dialogue = true
		DialogueCalc.start_dialogue(marker_2d.global_position, lines)
