@abstract
extends Node
class_name BaseState

signal transitioned(state_emiting: BaseState, new_state_name: String)

@abstract func enter()

@abstract func exit()

@abstract func update(_delta: float)

@abstract func physics_process(_delta: float)
