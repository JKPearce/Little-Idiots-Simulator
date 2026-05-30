extends Interactable
class_name Storage

func interact(entity: Entity) -> void:
	if entity.is_holding_item():
		var item := entity.held_item
		var amount := entity.held_amount

		WorldState.storage[item] = WorldState.storage.get(item, 0) + amount
		entity.clear_held_item()
		return
	
	if WorldState.storage.get("food", 0) <= 0:
		return

	WorldState.storage["food"] -= 1

	entity.needs[Entity.NEED.HUNGER] = clampf(
		entity.needs[Entity.NEED.HUNGER] - 0.8,
		0.0,
		1.0
	)

func _process(delta: float) -> void:
	var lines := []

	for item in WorldState.storage:
		lines.append("%s: %s" % [item.capitalize(), WorldState.storage[item]])

	%Storage.text = "\n".join(lines)
