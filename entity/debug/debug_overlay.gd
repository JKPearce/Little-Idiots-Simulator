extends Control

@export var entity: Entity
@export var utility_brain: UtilityAiBrain

@export var debug_enabled:= true

@onready var current_action_overlay: Label = %CurrentActionOverlay
@onready var stat_container: VBoxContainer = %StatContainer
@onready var action_score_container: VBoxContainer = %ActionScoreContainer


var stat_labels := {}
var action_score_labels := {}

func _ready() -> void:
	if debug_enabled:
		create_stat_labels()
		create_action_score_labels()


func create_stat_labels() -> void:
	for need in entity.needs:
		var label := Label.new()
		stat_labels[need] = label
		stat_container.add_child(label)


func create_action_score_labels() -> void:
	for child in utility_brain.get_children():
		if not child is UtilityAiAction:
			continue

		var action := child as UtilityAiAction
		var action_id: String = action.get_action_id()

		var label := Label.new()
		action_score_labels[action_id] = label
		action_score_container.add_child(label)



func _process(_delta: float) -> void:
	if debug_enabled:
		update_current_action()
		update_stats()
		update_action_scores()


func update_current_action() -> void:
	current_action_overlay.text = "Action: " + str(entity.current_action)


func update_stats() -> void:
	for need in entity.needs:
		var need_name: String = Entity.NEED.keys()[need]
		var need_value: float = entity.needs[need]

		stat_labels[need].text = "%s: %.2f" % [need_name.capitalize(), need_value]


func update_action_scores() -> void:
	var scores := utility_brain.get_all_scores()

	for score_data in scores:
		var action_id: String = score_data["action"]
		var score: float = score_data["score"]

		if not action_score_labels.has(action_id):
			var label := Label.new()
			action_score_labels[action_id] = label
			action_score_container.add_child(label)

		action_score_labels[action_id].text = "%s: %.3f" % [
			action_id.capitalize(),
			score
		]
