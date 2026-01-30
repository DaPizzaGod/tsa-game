extends StaminaDamage

@onready var up := $Positions/PositionUp
@onready var down := $Positions/PositionDown
var going_up := true
var spacing := 225
func _ready() -> void:
	damage = 5
	up.position.y = -spacing
	print(up.position)
	down.position.y = spacing
	print(down.position)
	position = down.position
	print(position)

func _process(_delta: float) -> void:
	# moving up and down
	if going_up:
		var tween = create_tween()
		tween.tween_property(self, "position", up.position, 1).set_ease(Tween.EASE_IN)
		await tween.finished
		going_up = false
	elif !going_up:
		var tween = create_tween()
		tween.tween_property(self, "position", down.position, 1).set_ease(Tween.EASE_IN)
		await tween.finished
		going_up = true
	
	


func _on_damage_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		hit_player()
	else:
		print("denied")
