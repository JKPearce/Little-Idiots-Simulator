extends UtilityAiConsideration
class_name StorageHasItemConsideration

@export var storage_key : String = ""


func score() -> float:
	if storage_key == "":
		push_error("Storage key not set for '%s'" % name)
		return 0.0

	return 1.0 if WorldState.storage.get(storage_key, 0) > 0 else 0.0
