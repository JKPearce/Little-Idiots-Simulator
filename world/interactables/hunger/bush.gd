extends Interactable
class_name Bush


func interact(entity: Entity) -> void:
	print(entity, " is interacting with Bush")
	entity.needs[Entity.NEED.HUNGER] = clampf(
		entity.needs[Entity.NEED.HUNGER] - quality,
		0.0,
		1.0
	)
	
	useable = false
	start_respawn()


func start_respawn() -> void:
	%AnimationPlayer.play("despawn")
	await %RespawnTimer.timeout



func _on_respawn_timer_timeout() -> void:
	%AnimationPlayer.play("grow")
	useable = true
