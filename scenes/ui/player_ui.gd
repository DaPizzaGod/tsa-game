extends CanvasLayer

@onready var stamina_bar := $StaminaBar
@onready var bar_text := $StaminaBar/BarText

func _ready() -> void:
	stamina_bar.max_value = StaminaCalc.max_stamina
	stamina_bar.value = stamina_bar.max_value

func _process(_delta: float) -> void:
	if StaminaCalc.update_stamina:
		update_stamina_bar()

func update_stamina_bar():
	stamina_bar.value = StaminaCalc.current_stamina
	bar_text.text = "%d / %d" %[stamina_bar.value, stamina_bar.max_value]
	StaminaCalc.update_stamina = false
