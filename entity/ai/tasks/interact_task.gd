# InteractTask.gd
extends BaseTask
class_name InteractTask

var target: Interactable

func _init(target_node: Interactable) -> void:
	target = target_node

func tick(entity: Entity, delta: float) -> bool:
	if target == null or not is_instance_valid(target):
		return true

	entity.visuals.play_interact(target)
	target.interact(entity)
	return true
