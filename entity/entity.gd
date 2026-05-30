extends CharacterBody2D
class_name Entity

@onready var state_machine: StateMachine = %StateMachine
@onready var brain: UtilityAiBrain = %UtilityAiBrain
@onready var task_runner: TaskRunner = %TaskRunner
@onready var visuals: EntityVisuals = $EntityVisuals



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
var source_target: Interactable = null
var destination_target: Interactable = null

var held_item: String = ""
var held_amount := 0



func is_holding_item() -> bool:
	return held_item != "" and held_amount > 0


func clear_held_item() -> void:
	held_item = ""
	held_amount = 0


func _ready() -> void:
	print("Visuals: ", visuals)
	print("Visuals sprite: ", visuals.sprite if visuals else null)
	print("Visuals anim: ", visuals.animation_player if visuals else null)
	brain.top_action_changed.connect(_on_top_action_changed)

#make it work, make it ugly - this functions mantra lol
func _on_top_action_changed(action_id: String) -> void:
	if is_busy:
		return

	match action_id:
		"eat":
			commit_eat()

		"sleep":
			commit_sleep()

		"gather_food":
			commit_gather_resource("gather_food", "food_source")
			
		"gather_wood":
			commit_gather_resource("gather_wood", "wood_source")
			
		"gather_stone":
			commit_gather_resource("gather_stone", "stone_source")

		"idle":
			commit_idle()

func commit_sleep() -> void:
	var bed := WorldState.get_closest_available_target("energy_source", global_position, self)

	if bed == null:
		current_action = "idle"
		state_machine.change_state("idle")
		return

	bed.reserve(self)
	target = bed

	task_runner.set_tasks([
		MoveToTask.new(bed),
		InteractTask.new(bed),
	])

	current_action = "sleep"
	is_busy = true
	state_machine.change_state("ExecuteTaskSequence")


func commit_eat() -> void:
	var storage := WorldState.get_closest_available_target("storage", global_position, self)

	if storage == null:
		current_action = "idle"
		state_machine.change_state("idle")
		return

	target = storage

	task_runner.set_tasks([
		MoveToTask.new(storage),
		InteractTask.new(storage),
	])

	current_action = "eat"
	is_busy = true
	state_machine.change_state("ExecuteTaskSequence")

func commit_gather_resource(action_id: String, source_group: String) -> void:
	var source := WorldState.get_closest_available_target(source_group, global_position, self)
	var destination := WorldState.get_closest_available_target("storage", global_position, self)

	if source == null or destination == null:
		commit_idle()
		return

	source.reserve(self)

	source_target = source
	destination_target = destination

	task_runner.set_tasks([
		MoveToTask.new(source),
		InteractTask.new(source),
		MoveToTask.new(destination),
		InteractTask.new(destination),
	])

	current_action = action_id
	is_busy = true
	state_machine.change_state("ExecuteTaskSequence")


func commit_idle() -> void:
	if target:
		target.release(self)

	if source_target:
		source_target.release(self)

	if destination_target:
		destination_target.release(self)

	task_runner.clear()

	target = null
	source_target = null
	destination_target = null

	current_action = "idle"
	is_busy = false
	state_machine.change_state("idle")

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
	task_runner.clear()

	if target:
		target.release(self)

	if source_target:
		source_target.release(self)

	if destination_target:
		destination_target.release(self)

	target = null
	source_target = null
	destination_target = null

	current_action = "idle"
	is_busy = false
	state_machine.change_state("idle")
