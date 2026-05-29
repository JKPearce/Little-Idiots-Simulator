extends State
class_name Idle


func enter() -> void:
	entity.velocity = Vector2.ZERO
	entity.visuals.play_idle()
