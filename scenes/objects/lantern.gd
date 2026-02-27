extends RigidBody2D


@onready var hitbox := $CollisionPolygon2D


func _on_pick_up_zone_body_entered(body: Node2D) -> void:
	if not ThrowCalc.throwing:
		hitbox.set_deferred("disabled", false)
		if body.is_in_group("Players"):
			ThrowCalc.lantern_holding = self
			ThrowCalc.picked_up = true

		
func _ready() -> void:
	ThrowCalc.picked_up = false
	ThrowCalc.lantern_holding = null
	

func _physics_process(_delta: float) -> void:
	
	if ThrowCalc.picked_up:

		position = ThrowCalc.player_pos
		hitbox.set_deferred("disabled", true)
	else:
		hitbox.set_deferred("disabled", false)
		

		
	if ThrowCalc.throwing:
		ThrowCalc.picked_up = false
		hitbox.set_deferred("disabled", true)
		await get_tree().create_timer(0.1).timeout
		hitbox.set_deferred("disabled", false)
	
	if ThrowCalc.hand_lantern_attatched:
		#print(linear_velocity)
		#var old_vel = linear_velocity
		linear_velocity = Vector2.ZERO
		await get_tree().create_timer(1.5).timeout
		linear_velocity = Vector2(0, ProjectSettings.get_setting("physics/2d/default_gravity"))
		
