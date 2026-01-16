extends Panel

class_name InvUiSlot

signal clicked(index: int)

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/Label

var index: int = -1

func update(slot: InvSlot):
	if slot == null or slot.item == null:
		item_visual.visible = false
		amount_text.visible = false
		return

	item_visual.visible = true
	item_visual.texture = slot.item.texture

	if slot.amount > 1:
		amount_text.visible = true
		amount_text.text = str(slot.amount)
	elif slot.amount < 1:
		item_visual.visible = false
		amount_text.visible = false

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed:
		clicked.emit(index)
