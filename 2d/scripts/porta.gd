extends Node2D
# So serve pra mostrar o tutorial do F


func _on_porta_area_body_entered(body: Node2D) -> void:
	if body.name == "Jogador2D":
		var f_tuto: Array[Node] = get_tree().get_nodes_in_group("FTutorial")
		for node in f_tuto:
			node.visible = true
			node.play("default")


func _on_porta_area_body_exited(body: Node2D) -> void:
	if body.name == "Jogador2D":
		var f_tuto: Array[Node] = get_tree().get_nodes_in_group("FTutorial")
		for node in f_tuto:
			node.visible = false
