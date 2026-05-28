extends Interactable
class_name Bed

func interact(entity: Entity) -> void:
	print(entity, " is interacting with Bed")
	entity.needs[Entity.NEED.ENERGY] = clampf(
		entity.needs[Entity.NEED.ENERGY] + quality,
		0.0,
		1.0
	)
	
