extends Control

@onready var inv: Inv = preload("res://inventory/playerinv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

func _ready() -> void:
	inv.update.connect(update_slots)

	for i in range(inv.slots.size()):
		slots[i].clicked.connect(_on_slot_clicked)
		slots[i].index = i

	update_slots()
	close()

func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("i"):
		if is_open:
			close()
		else:
			open()

func _on_slot_clicked(i: int) -> void:
	if inv.slots[i].item and inv.slots[i].amount > 1:
		inv.slots[i].amount -= 1
		print(str(inv.slots[i].amount))
		update_slots()
	elif inv.slots[i].item and inv.slots[i].amount == 1:
		inv.slots[i].item = null
		update_slots()
	print("cliqué slot = ", i)
	print("data slot item = ", inv.slots[i].item)

func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
