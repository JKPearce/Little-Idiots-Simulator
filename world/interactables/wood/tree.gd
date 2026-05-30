extends Interactable
class_name TreeNode

func interact(entity: Entity) -> void:
	if not useable:
		return

	print(entity, " is gathering wood from Tree: ", self)

	entity.held_item = "wood"
	entity.held_amount = 1

	useable = false
	release(entity)
	queue_free()
