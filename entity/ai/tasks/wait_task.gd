extends BaseTask
class_name WaitTask

var duration := 1.0
var timer := 0.0
var effect_name := ""

func _init(seconds: float, effect := "") -> void:
	duration = seconds
	effect_name = effect

func start(entity: Entity) -> void:
	timer = duration
	entity.velocity = Vector2.ZERO

	if effect_name != "":
		entity.visuals.play_effect(effect_name)

func tick(entity: Entity, delta: float) -> bool:
	entity.velocity = Vector2.ZERO
	timer -= delta
	return timer <= 0.0
