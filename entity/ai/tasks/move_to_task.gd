extends BaseTask
class_name MoveToTask

var target_position: Vector2
var arrive_distance := 4.0


func _init(pos: Vector2) -> void:
	target_position = pos


func tick(entity: Entity, _delta: float) -> TaskStatus:
	var to := target_position - entity.global_position
	var distance := to.length()

	# arrived
	if distance <= arrive_distance:
		entity.velocity = Vector2.ZERO
		return TaskStatus.SUCCESS

	# move
	var direction := to.normalized()

	entity.rotation = direction.angle()
	entity.velocity = direction * entity.speed
	entity.move_and_slide()

	return TaskStatus.RUNNING
