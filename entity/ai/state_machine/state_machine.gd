extends Node
class_name StateMachine

@export var default_state: State

var states: Dictionary = {}
var current_state: State = null


func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_machine = self

	if default_state:
		change_state(default_state.name)


func _process(delta: float) -> void:
	if current_state:
		current_state.process(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_process(delta)


func change_state(state_name: String) -> void:
	var key := state_name.to_lower()

	if !states.has(key):
		push_warning("State not found: " + state_name)
		return

	if current_state:
		current_state.exit()

	current_state = states[key]
	current_state.enter()
