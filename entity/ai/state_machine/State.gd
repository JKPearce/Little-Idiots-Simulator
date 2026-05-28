extends Node
class_name State

var state_machine: StateMachine
@export var entity: Entity


func enter() -> void:
	pass


func exit() -> void:
	pass


func process(_delta: float) -> void:
	pass


func physics_process(_delta: float) -> void:
	pass


func change_state(state_name: String) -> void:
	state_machine.change_state(state_name)
