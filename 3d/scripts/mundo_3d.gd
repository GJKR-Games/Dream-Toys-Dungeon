extends Node3D


func _ready() -> void:
	$CanvasLayer/Control/AnimatedSprite2D.play("default")
	get_tree().create_timer(5).timeout.connect(func(): $CanvasLayer/Control/AnimatedSprite2D.visible = false)
	
