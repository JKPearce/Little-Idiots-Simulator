extends Interactable
class_name RockNode

func interact(entity: Entity) -> void:
	if not useable:
		return

	print(entity, " is gathering stone from rock: ", self)

	entity.held_item = "stone"
	entity.held_amount = 1

	useable = false
	release(entity)
	queue_free()
