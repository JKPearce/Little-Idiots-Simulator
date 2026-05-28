extends Node

var interactable_target_nodes := {
	"hunger": [],
	"energy": [],
}


func register_interactable_target_node(group_name: String, node: Node2D) -> void:
	if not interactable_target_nodes.has(group_name):
		interactable_target_nodes[group_name] = []

	if not interactable_target_nodes[group_name].has(node):
		interactable_target_nodes[group_name].append(node)


func unregister_interactable_target_node(group_name: String, node: Node2D) -> void:
	if interactable_target_nodes.has(group_name):
		interactable_target_nodes[group_name].erase(node)


func has_available_target(group_name: String, entity: Entity) -> bool:
	if not interactable_target_nodes.has(group_name):
		return false

	for target in interactable_target_nodes[group_name]:
		if not is_instance_valid(target):
			continue

		if target.is_available_for(entity):
			return true

	return false


func get_closest_available_target(
	group_name: String,
	from_position: Vector2,
	entity: Entity
) -> Interactable :
	if not interactable_target_nodes.has(group_name):
		return null

	var closest: Node2D = null
	var closest_distance := INF

	for target in interactable_target_nodes[group_name]:
		if not is_instance_valid(target):
			continue

		if not target.is_available_for(entity):
			continue

		var distance := from_position.distance_squared_to(target.global_position)

		if distance < closest_distance:
			closest_distance = distance
			closest = target

	return closest
