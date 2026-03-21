extends RigidBody2D


@onready var hitbox := $CollisionShape2D
var hooked := false
var lantern_hook_pos :Vector2
@export var hooked_texture_scale: float
var can_hook:= true

func _on_pick_up_zone_body_entered(body: Node2D) -> void:
	if not ThrowCalc.throwing:
		if body.is_in_group("Players") and not hooked and not ThrowCalc.picked_up:
			ThrowCalc.lantern_holding = self
			ThrowCalc.picked_up = true
	if body.is_in_group("LanternHook") and not ThrowCalc.picked_up:
		
		for i in ThrowCalc.blocked_hooks:
			
			if i == body:
				can_hook = false
		if can_hook:
			ThrowCalc.blocked_hooks.append(body)
			get_hooked()
			lantern_hook_pos = body.position
			can_hook = true
		
		
func get_hooked():
	rotation = 0
	ThrowCalc.current_lanterns += 1
	hooked = true
	hitbox.set_deferred("disabled", true)
	var tween = create_tween()
	tween.tween_property($PointLight2D, "texture_scale", hooked_texture_scale, 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	

		
		
func _ready() -> void:
	ThrowCalc.picked_up = false
	ThrowCalc.lantern_holding = null
	LevelCalc.connect("finish_level", _on_finish_level)
	

func _physics_process(_delta: float) -> void:
	if hooked:
		position = lantern_hook_pos

	
	if ThrowCalc.picked_up and ThrowCalc.lantern_holding == self:
		
		position = ThrowCalc.player_pos
		hitbox.set_deferred("disabled", true)
		#hitbox.set_collision_mask_value
	else:
		hitbox.set_deferred("disabled", false)
		set_collision_mask_value(1, false)

	if ThrowCalc.throwing:

		ThrowCalc.picked_up = false
		hitbox.set_deferred("disabled", true)
		await get_tree().create_timer(0.3).timeout
		hitbox.set_deferred("disabled", false)
		await get_tree().create_timer(0.3).timeout
		set_collision_mask_value(1, true)
		
	if ThrowCalc.hand_lantern_attatched:
		set_freeze_enabled(true)
		await get_tree().create_timer(1.5).timeout
		set_freeze_enabled(false)
		

func _on_finish_level():
	ThrowCalc.lantern_holding = null
	queue_free()
