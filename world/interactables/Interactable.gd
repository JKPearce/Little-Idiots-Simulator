extends Node2D
class_name Interactable

@export var target_group := ""
@export_range(0.0, 1.0) var quality := 0.25
@export var useable:= true

var reserved_by: Entity = null

func _ready() -> void:
	if target_group == "":
		push_error("Target group not set for '%s'" % name)
		return

	WorldState.register_interactable_target_node(target_group, self)


func _exit_tree() -> void:
	if target_group == "":
		return

	WorldState.unregister_interactable_target_node(target_group, self)


func interact(entity: Entity) -> void:
	pass


func is_available_for(entity: Entity) -> bool:
	if not useable:
		return false

	if reserved_by != null and reserved_by != entity:
		return false

	return true

func reserve(entity: Entity) -> void:
	reserved_by = entity

func release(entity: Entity) -> void:
	if reserved_by == entity:
		reserved_by = null
