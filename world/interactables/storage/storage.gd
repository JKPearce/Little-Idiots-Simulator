extends Interactable
class_name Storage

func interact(entity: Entity) -> void:
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
