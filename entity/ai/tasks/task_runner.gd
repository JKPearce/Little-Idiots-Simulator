# TaskRunner.gd
extends Node
class_name TaskRunner

var tasks: Array[BaseTask] = []
var current_task: BaseTask = null


func set_tasks(new_tasks: Array[BaseTask]) -> void:
	clear()
	tasks = new_tasks


func clear() -> void:
	tasks.clear()
	current_task = null


func has_tasks() -> bool:
	return current_task != null or not tasks.is_empty()


func tick(entity: Entity, delta: float) -> bool:
	if current_task == null:
		if tasks.is_empty():
			return true

		current_task = tasks.pop_front()
		current_task.start(entity)

	var done := current_task.tick(entity, delta)

	if done:
		current_task.finish(entity)
		current_task = null

	return false
