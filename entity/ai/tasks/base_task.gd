extends RefCounted
class_name BaseTask


enum TaskStatus {
	RUNNING,
	SUCCESS,
	FAILED
}


func tick(_entity: Entity, _delta: float) -> TaskStatus:
	return TaskStatus.SUCCESS
