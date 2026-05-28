extends UtilityAiConsideration
class_name HungerConsideration

#hunger generally will only return its current value  since theres not really anything to consider in worldstate

func score() -> float:
	return entity.needs[Entity.NEED.HUNGER]
