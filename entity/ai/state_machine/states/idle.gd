extends State
class_name Idle

#currently i dont have any idle animations so im just gonna rotate it randomly around in circles lol 


var rotation_speed := 0.0
var timer := 0.0


func enter() -> void:
	entity.velocity = Vector2.ZERO
	pick_new_idle_motion()

func exit() -> void:
	reset_rotation_smooth()

func process(delta: float) -> void:
	timer -= delta

	entity.entity_sprite.rotation += rotation_speed * delta

	if timer <= 0.0:
		pick_new_idle_motion()


func pick_new_idle_motion() -> void:
	timer = randf_range(0.5, 2.5)
	rotation_speed = randf_range(-1.0, 1.0)


func change_state(state_name: String) -> void:
	state_machine.change_state(state_name)


func reset_rotation_smooth():
	var tween = create_tween()
	# Rotates to 0 over 0.2 seconds using a clean deceleration curve
	tween.tween_property(entity.entity_sprite, "rotation", 0.0, 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
