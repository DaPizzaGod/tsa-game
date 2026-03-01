extends RigidBody2D


@onready var hitbox := $CollisionPolygon2D
var hooked := false


func _on_pick_up_zone_body_entered(body: Node2D) -> void:
	if not ThrowCalc.throwing:
		if body.is_in_group("Players") and not hooked:
			ThrowCalc.lantern_holding = self
			ThrowCalc.picked_up = true
	elif body.is_in_group("LanternHook"):
		stay_hooked(body.position)
		
		
func stay_hooked(lantern_hook_pos):
	hooked = true
	hitbox.set_deferred("disabled", true)
	while true:
		position = lantern_hook_pos
		
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
		set_freeze_enabled(true)
		await get_tree().create_timer(1.5).timeout
		set_freeze_enabled(false)
		
