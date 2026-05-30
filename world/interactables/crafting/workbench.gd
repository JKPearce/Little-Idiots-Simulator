extends Interactable
class_name Workbench

@export var craft_time := 3.0
@export var output_item := "tool"
@export var output_amount := 1



func interact(entity: Entity) -> void:
	if WorldState.storage.get("wood", 0) < 1:
		return

	if WorldState.storage.get("stone", 0) < 1:
		return

	WorldState.storage["wood"] -= 1
	WorldState.storage["stone"] -= 1
	WorldState.storage["tool"] = WorldState.storage.get("tool", 0) + 1
