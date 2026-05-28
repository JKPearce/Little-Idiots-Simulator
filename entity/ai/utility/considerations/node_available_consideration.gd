extends UtilityAiConsideration
class_name  NodeAvailableConsideration

#set the group name
@export var target_group:= ""

func score() -> float:
	if target_group == "":
		push_error("Target node not set for consideration '%s' " % self.name)
		return 0.0
	
	return 1.0 if WorldState.has_available_target(target_group, entity) else 0.0
