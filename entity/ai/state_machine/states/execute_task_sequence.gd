extends State
class_name ExecuteTaskSequence

func exit() -> void:
	entity.velocity = Vector2.ZERO

func physics_process(delta: float) -> void:
	var finished := entity.task_runner.tick(entity, delta)

	if finished:
		entity.finish_action()
