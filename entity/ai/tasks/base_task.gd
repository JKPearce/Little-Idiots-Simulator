# BaseTask.gd
class_name BaseTask
extends RefCounted

var started := false

func start(entity: Entity) -> void:
	started = true

func tick(entity: Entity, delta: float) -> bool:
	return true

func finish(entity: Entity) -> void:
	pass
