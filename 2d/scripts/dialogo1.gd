extends Node2D

var player_na_area = false
var ja_interagiu = false

func _input(event):
	if event.is_action_pressed("ui_interact"):
		var gerenciador_dialogo = get_tree().get_first_node_in_group("gerenciadordialogo")
		if (gerenciador_dialogo != null && player_na_area):
			var block_area: RigidBody2D = get_tree().get_first_node_in_group("BlockProgredir")
			if block_area != null:
				block_area.collision_layer = 0
			gerenciador_dialogo.show_dialogue("[font_size=24][b]Grandpa:[/b][center]\nYou've been eating cashews all day, right?\nNo problem, just go to your house before it gets too dark.\nI've put the toys you were afraid of away, but if you get [b]nightmares[/b] again let me know!![/center][/font_size]")
			#gerenciador_dialogo.show_dialogue("Ficou o dia todo comendo caju né?\nSem problemas, vá para a casa.\nEu guardei os brinquedos que você estava com medo, mas se tiver pesadelos novamente me avise!!")
		elif (gerenciador_dialogo != null && not player_na_area):
			gerenciador_dialogo.close_dialogue()

func _on_dialogo_area_body_entered(body: Node2D) -> void:
	if body.name == "Jogador2D":
		player_na_area = true
		var f_tuto: AnimatedSprite2D = get_tree().get_first_node_in_group("FTutorial")
		if f_tuto != null:
			f_tuto.visible = true
			f_tuto.play("default")
			
func _on_dialogo_area_body_exited(body: Node2D) -> void:
	if body.name == "Jogador2D":
		player_na_area = false
		var f_tuto: AnimatedSprite2D = get_tree().get_first_node_in_group("FTutorial")
		if f_tuto != null:
			f_tuto.visible = false
