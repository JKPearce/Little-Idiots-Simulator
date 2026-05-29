extends Interactable
class_name Bush

@export var respawn_time: = 1.0

func interact(entity: Entity) -> void:
	if not useable:
		return

	print(entity, " is gathering food from Bush")

	entity.held_item = "food"
	entity.held_amount = 1

	useable = false
	start_respawn()


func start_respawn() -> void:
	%AnimationPlayer.play("despawn")
	%RespawnTimer.start(respawn_time)



func _on_respawn_timer_timeout() -> void:
	%AnimationPlayer.play("grow")
	useable = true
