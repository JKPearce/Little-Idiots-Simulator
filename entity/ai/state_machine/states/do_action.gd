extends State
class_name DoAction


func enter() -> void:
	pass


func exit() -> void:
	entity.velocity = Vector2.ZERO


func process(_delta: float) -> void:
	pass


func physics_process(_delta: float) -> void:
	if entity.target == null:
		entity.finish_action()
		return

	move_to(entity.target.global_position)


func move_to(target_position: Vector2) -> void:
	var to := target_position - entity.global_position
	var distance := to.length()
	var arrive_distance := entity.target.interaction_distance if entity.target else 8.0

	if distance <= arrive_distance:
		entity.velocity = Vector2.ZERO
		_on_arrived()
		return

	var direction := to.normalized()
	entity.entity_sprite.rotation = direction.angle()
	entity.velocity = direction * entity.speed
	entity.move_and_slide()


func _on_arrived() -> void:
	match entity.current_action:
		"gather_food":
			_handle_gather_food_step()

		_:
			entity.target.interact(entity)
			entity.finish_action()


func _handle_gather_food_step() -> void:
	if entity.action_step == 0:
		entity.source_target.interact(entity)
		entity.target = entity.destination_target
		entity.action_step = 1
		return

	if entity.action_step == 1:
		entity.destination_target.interact(entity)
		entity.finish_action()
