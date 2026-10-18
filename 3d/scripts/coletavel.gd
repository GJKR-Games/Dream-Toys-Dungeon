extends Node3D

var player_na_area = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_interact") and player_na_area:
		var player = get_tree().get_first_node_in_group("player3d")
		if player != null:
			player.add_coletado()
			queue_free()
		

func _on_coletavel_area_body_entered(body: Node3D) -> void:
	if body.name == "Jogador3D":
		player_na_area = true
		var letra_f: AnimatedSprite2D = get_tree().get_first_node_in_group("LetraF")
		if letra_f != null:
			letra_f.visible = true

func _on_coletavel_area_body_exited(body: Node3D) -> void:
	if body.name == "Jogador3D":
		player_na_area = false
		var letra_f: AnimatedSprite2D = get_tree().get_first_node_in_group("LetraF")
		if letra_f != null:
			letra_f.visible = false
