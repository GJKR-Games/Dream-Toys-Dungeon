extends BaseState
class_name PlayerIdle2D

@export var player_2d: Player2D

func enter():
	pass

func exit():
	pass

func update(_delta: float):
	pass

func physics_process(_delta: float) -> void:
	if player_2d.input_direction != Vector2.ZERO:
		transitioned.emit(self, "PlayerMove2D")
	
	player_2d.move(0, 15, _delta)
	player_2d.move_and_slide()
