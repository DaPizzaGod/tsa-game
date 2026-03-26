extends Node2D

const lines: Array[String] = [
	"You've persevered through my challenges, I see...", 
	"I am the Panic Inner Demon, and...",
	"for overcoming the Panic of these levels!", 
	"I shall grant you a new gift"
]
@onready var area_2d: Area2D = $Area2D
@onready var marker_2d: Marker2D = $Marker2D
var started_dialogue:= false

func _process(_delta: float) -> void:
	if area_2d.get_overlapping_bodies().size() > 0 and not started_dialogue:
		started_dialogue = true
		DialogueCalc.start_dialogue(marker_2d.global_position, lines)
		
