extends Interactable
class_name Storage

func interact(entity: Entity) -> void:
	#entity is depositing food
	if entity.is_holding_item():
		WorldState.storage[entity.held_item] += entity.held_amount
		entity.clear_held_item()
		return
	
	#entity is eating food
	if WorldState.storage.get("food", 0) <= 0:
		return

	WorldState.storage["food"] -= 1

	entity.needs[Entity.NEED.HUNGER] = clampf(
		entity.needs[Entity.NEED.HUNGER] - 0.8,
		0.0,
		1.0
	)

func _process(delta: float) -> void:
	%Storage.text = "Food: " + str(WorldState.storage["food"])
