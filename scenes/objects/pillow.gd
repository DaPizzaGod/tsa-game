extends StaminaDamage

@onready var up := $Positions/PositionUp
@onready var down := $Positions/PositionDown
var going_up := true
var spacing := 225
var nodesx : float
var tween: Tween

func _ready() -> void:
	nodesx = self.position.x
	damage = 5
	

	up.position = Vector2(nodesx, -spacing)
	down.position = Vector2(nodesx, spacing)
	
	position.y = down.position.y
	print(position, up.position, down.position)
	print(nodesx)
	move()
'''
func _process(_delta: float) -> void:
	# moving up and down
	if position.x == nodesx:
		move()
		
		await tween.finished
		going_up = !going_up
	else:
		push_error("failed")
'''
func move():
	while is_inside_tree():
		tween = create_tween()
		
		if going_up:

			tween.tween_property(self, "position", up.position, 1).set_ease(Tween.EASE_IN)
		elif !going_up:

			tween.tween_property(self, "position", down.position, 1).set_ease(Tween.EASE_IN)
		
		await  tween.finished
		going_up = !going_up


func _on_damage_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		hit_player()
	else:
		print("denied")
