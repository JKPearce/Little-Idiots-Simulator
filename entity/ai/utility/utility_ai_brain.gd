extends Node
class_name UtilityAiBrain

## Emitted when the highest scoring action changes.
signal top_action_changed(action_id: String)

## Enable or disable the brain.
@export var enabled: bool = true

## How often the brain reconsiders its best action.
@export var decision_interval := 0.5

var _current_top_action_id: String = ""
var _action_scores: Array = []
var _score_sorted := false
var _decision_timer := 0.0


func _physics_process(delta: float) -> void:
	if not enabled:
		return

	_decision_timer -= delta

	if _decision_timer <= 0.0:
		_decision_timer = decision_interval
		_process_actions()


func _process_actions() -> void:
	var actions := get_children()

	if actions.is_empty():
		push_warning("UtilityAiBrain should have at least one UtilityAiAction child.")
		return

	var top_action := _get_highest_utility_action(actions)

	if top_action == null:
		return

	var top_action_id = top_action.get_action_id()

	top_action_changed.emit(top_action_id)


func _get_highest_utility_action(actions: Array) -> UtilityAiAction:
	var top_action: UtilityAiAction = null
	var top_action_utility := -1.0
	var all_scores := []

	for child in actions:
		if not child is UtilityAiAction:
			push_warning("Child '%s' is not a UtilityAiAction." % child.name)
			continue

		var action := child as UtilityAiAction
		var score := action.calculate_score()

		all_scores.push_back({
			"action": action.get_action_id(),
			"score": score,
		})

		if score > top_action_utility:
			top_action_utility = score
			top_action = action

	_action_scores = all_scores
	_score_sorted = false

	return top_action


## Returns the last calculated scores from highest to lowest.
## Does not recalculate.
##
## Array<{ "action": String, "score": float }>
func get_all_scores() -> Array:
	if not _score_sorted:
		_action_scores.sort_custom(func(a, b): return a["score"] > b["score"])
		_score_sorted = true

	return _action_scores
