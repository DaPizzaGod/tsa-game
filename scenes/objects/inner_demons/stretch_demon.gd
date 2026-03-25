extends Node2D

const lines: Array[String] = [
	"Haha, I am the Self-Doubt Inner Demon!",
	"Despite the challenges I sent you...",
	"you have proven worthy to overcome your doubt.",
	"I shall reward you with a special prize for you to take with your journey"
]
@onready var area_2d: Area2D = $Area2D
@onready var marker_2d: Marker2D = $Marker2D
var started_dialogue:= false

func _process(_delta: float) -> void:
	if area_2d.get_overlapping_bodies().size() > 0 and not started_dialogue:
		started_dialogue = true
		DialogueCalc.start_dialogue(marker_2d.global_position, lines)
		
