extends StaminaDamage

@onready var up := $Positions/PositionUp
@onready var down := $Positions/PositionDown
var going_up := true

func _ready() -> void:
	damage = 5
	position = down.position

func _process(_delta: float) -> void:
	# moving up and down
	if going_up:
		var tween = create_tween()
		tween.tween_property(self, "position", up.position, 1).set_ease(Tween.EASE_IN_OUT)
		await tween.finished
		going_up = false
	elif !going_up:
		var tween = create_tween()
		tween.tween_property(self, "position", down.position, 1).set_ease(Tween.EASE_IN_OUT)
		await tween.finished
		going_up = true
	
	


func _on_damage_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		hit_player()
