# MoveToTask.gd
extends BaseTask
class_name MoveToTask

var target: Interactable

func _init(target_node: Interactable) -> void:
	target = target_node

func tick(entity: Entity, delta: float) -> bool:
	if target == null or not is_instance_valid(target):
		return true

	var to := target.global_position - entity.global_position
	var distance := to.length()

	if distance <= target.interaction_distance:
		entity.velocity = Vector2.ZERO
		entity.visuals.play_idle()
		return true

	var direction := to.normalized()

	entity.visuals.play_move(direction)
	entity.velocity = direction * entity.speed
	entity.move_and_slide()

	return false
