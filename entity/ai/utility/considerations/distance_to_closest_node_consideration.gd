extends UtilityAiConsideration
class_name DistanceToClosestNodeConsideration
#
# This is an example for a custom consideration.
# This script checks if there is any node available in the given group.
#

@export var target_group: String = ""

@export var max_distance := 300.0

func score() -> float:
	var target : Interactable = WorldState.get_closest_available_target(
		target_group,
		entity.global_position,
		entity
	)

	if target == null:
		return 0.0

	var distance := entity.global_position.distance_to(target.global_position)
	return clampf(1.0 - distance / max_distance, 0.0, 1.0)
