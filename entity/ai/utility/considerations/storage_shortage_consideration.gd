extends UtilityAiConsideration
class_name StorageShortageConsideration

@export var storage_key: String = ""
@export var min_desired_amount := 3.0
@export var max_desired_amount := 10.0


func score() -> float:
	if storage_key == "":
		push_error("Storage key not set for '%s'" % name)
		return 0.0

	var item: float = float(WorldState.storage.get(storage_key, 0))

	if max_desired_amount <= min_desired_amount:
		push_error("Max desired amount must be greater than min desired amount for '%s'" % name)
		return 0.0

	return clampf(
		1.0 - inverse_lerp(min_desired_amount, max_desired_amount, item),
		0.0,
		1.0
	)
