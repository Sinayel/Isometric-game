extends Resource

class_name Inv

signal update

@export var slots: Array[InvSlot]

func insert(item: InvItem):
	# Si un slot contient deja un item
	var itemslots = slots.filter(
		func(slot): return slot.item == item and \
		slot.amount < slot.item.max_stack and \
		item.stackable)
	if !itemslots.is_empty():
		itemslots[0].amount += 1
	else:
		var emptyslots = slots.filter(
			func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
	update.emit()
