extends UtilityAiConsideration
class_name StorageShortageConsideration

@export var storage_key : String = ""
@export var desired_amount := 5.0


func score() -> float:
	var item: int = WorldState.storage[storage_key]
	return clampf(1.0 - item / desired_amount, 0.0, 1.0)
