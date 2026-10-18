extends Node3D


func entrar() -> void:
	$CanvasLayer/Control/AnimatedSprite2D.play("default")
	get_tree().create_timer(6).timeout.connect(func(): $CanvasLayer/Control/AnimatedSprite2D.visible = false)
	$CanvasLayer/LetraF.play("default")
