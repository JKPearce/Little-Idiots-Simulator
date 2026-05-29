extends Node2D
class_name Interactable

@export var target_group := ""
@export_range(0.0, 1.0) var quality := 0.25
@export var useable:= true
@export var interaction_animation := ""

var reserved_by: Entity = null
@export var requires_reservation := true
@export var interaction_distance := 24.0

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

	if requires_reservation and reserved_by != null and reserved_by != entity:
		return false

	return true

func reserve(entity: Entity) -> void:
	reserved_by = entity

func release(entity: Entity) -> void:
	if reserved_by == entity:
		reserved_by = null
