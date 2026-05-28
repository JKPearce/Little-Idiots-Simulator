extends CharacterBody2D
class_name Entity

@onready var state_machine: StateMachine = %StateMachine
@onready var entity_sprite: Sprite2D = %EntitySprite
@onready var brain: UtilityAiBrain = %UtilityAiBrain


@export var speed := 80.0

enum NEED {
	HUNGER,
	ENERGY,
}

var needs:= {
	NEED.HUNGER: 0.0, #hunger at 1 is very hungry, 0 hunger is not hungery
	NEED.ENERGY: 1.0, #energy at 1 is full energy, 0 energy is tired
}

#natural decays over time
@export var hunger_decay_rate := 0.02
@export var energy_decay_rate := 0.01

var current_action = null
var is_busy:= false
var target: Interactable = null


func _ready() -> void:
	brain.top_action_changed.connect(_on_top_action_changed)


func _on_top_action_changed(action_id: String) -> void:
	if is_busy:
		return

	match action_id:
		"eat":
			target = WorldState.get_closest_available_target("hunger", global_position, self)
			if target == null:
				current_action = "idle"
				perform_action()
				return
			target.reserve(self)
			current_action = action_id
			perform_action()

		"sleep":
			target = WorldState.get_closest_available_target("energy", global_position, self)
			if target == null:
				current_action = "idle"
				perform_action()
				return
			target.reserve(self)
			current_action = action_id
			perform_action()

		"idle":
			if target:
				target.release(self)
				target = null

			current_action = action_id
			perform_action()



func perform_action() -> void:
	if current_action == "idle" or target == null:
		state_machine.change_state("idle")
		return

	is_busy = true
	state_machine.change_state("DoAction")


func _process(delta: float) -> void:
	decay_needs(delta)


func decay_needs(delta: float) -> void:
	needs[NEED.HUNGER] = clampf(
		needs[NEED.HUNGER] + hunger_decay_rate * delta,
		0.0,
		1.0
	)

	needs[NEED.ENERGY] = clampf(
		needs[NEED.ENERGY] - energy_decay_rate * delta,
		0.0,
		1.0
	)


func finish_action() -> void:
	if target:
		target.release(self)
		target = null

	current_action = "idle"
	is_busy = false
	state_machine.change_state("idle")
