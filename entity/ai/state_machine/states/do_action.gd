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

	# arrived
	if distance <= 8.0:
		entity.velocity = Vector2.ZERO
		entity.target.interact(entity)
		entity.finish_action()
		return
	

	# move
	var direction := to.normalized()

	entity.entity_sprite.rotation = direction.angle()
	entity.velocity = direction * entity.speed
	entity.move_and_slide()
