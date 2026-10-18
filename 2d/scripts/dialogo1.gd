extends Node2D

var player_na_area = false

func _input(event):
	if event.is_action_pressed("ui_interact"): # Tecla Enter/Espaço
		var gerenciador_dialogo = get_tree().get_first_node_in_group("gerenciadordialogo")
		if (gerenciador_dialogo != null && player_na_area):
			gerenciador_dialogo.show_dialogue("Ficou o dia todo comendo caju né?\nSem problemas, vá para a casa.\nEu guardei os brinquedos que você estava com medo, mas se tiver pesadelos novamente me avise!!")
		elif (gerenciador_dialogo == null && not player_na_area):
			gerenciador_dialogo.close_dialogue()

func _on_dialogo_area_body_entered(body: Node2D) -> void:
	if body.name == "Jogador2D":
		player_na_area = true


func _on_dialogo_area_body_exited(body: Node2D) -> void:
	if body.name == "Jogador2D":
		player_na_area = false
