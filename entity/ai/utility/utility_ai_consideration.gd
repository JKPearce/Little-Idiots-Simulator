extends Node
class_name UtilityAiConsideration 

@export var entity: Entity #this is the entity blackboard that all considerations will probably use
@export var requires_entity := true

##
## The curve to be applied to the raw score.
##
@export var curve: Curve:
	set(value):
		curve = value
		update_configuration_warnings()


func calculate_score() -> float:
	if requires_entity and entity == null:
		push_error("Entity not set for '%s' consideration." % name)
		return 0.0
		
	return _apply_curve(score())


func _apply_curve(score: float) -> float:
	if curve == null:
		push_error("'curve' not defined for '%s' consideration." % self.name)
		return 0.0

	return curve.sample_baked(score)

##
## This method should be overwritten by the child class. Return value should be between 0.0 and 1.0 inclusive.
##
func score() -> float:
	return 0.0


func _get_configuration_warnings():
	var warnings = []

	var current_script = get_script().get_path()
	# not sure if there is a better way to validate if script was extended
	# instead of relying on the actual path.
	if current_script == "res://addons/utility_ai/considerations/consideration.gd":
		warnings.push_back("Consideration script needs to be extended and 'score' method implemented")

	if curve == null:
		warnings.push_back("Curve not set")

	return warnings
