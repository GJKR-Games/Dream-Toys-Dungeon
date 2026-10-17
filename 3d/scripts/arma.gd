extends Node3D

@onready var animation := $CanvasLayer/AnimationPlayer
@onready var audio := $CanvasLayer/Audio

func _ready() -> void:
	animation.play("idle")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		audio.play() # TODO: colocar o audio no node em si, ta sem som
		animation.play("atirar")
		
