extends Node

@onready var mundo_3d = $Mundo3D
@onready var mundo_2d = $Mundo2D
@onready var musica_2d = $"2DMusica"
@onready var musica_3d = $"3DMusica"

var to_no_3d = false

func _input(event: InputEvent) -> void:
	if ganhei: return
	if event.is_action_pressed("ui_pause"):
		if not to_no_3d:
			if mundo_2d.process_mode == Node.PROCESS_MODE_DISABLED:
				create_tween().tween_property($Censura2D, "modulate:a", 0, 0.5)
				mundo_2d.process_mode = Node.PROCESS_MODE_INHERIT
				$PauseLabel.visible = false
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			
			elif mundo_2d.process_mode == Node.PROCESS_MODE_INHERIT:
				var nodes_2d = get_all_children(mundo_2d)
				for node in nodes_2d:
					if node.name == "Jogador2D":
						$PauseLabel.global_position = Vector2(int(node.global_position.x - 67.0/2), int(node.global_position.y - 23.0/2))
						$Censura2D.global_position = Vector2(int(node.global_position.x - 412.0/2), int(node.global_position.y - 281.0/2))
				
				$PauseLabel.visible = true
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
				create_tween().tween_property($Censura2D, "modulate:a", 0.67, 0.5)
				mundo_2d.process_mode = Node.PROCESS_MODE_DISABLED
		else:
			if mundo_3d.process_mode == Node.PROCESS_MODE_DISABLED:
				create_tween().tween_property($Censura2D, "modulate:a", 0, 0.5)
				mundo_3d.process_mode = Node.PROCESS_MODE_INHERIT
				$PauseLabel.visible = false
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
				var nodes_3d = get_all_children(mundo_3d)
				for node in nodes_3d:
					if node.name == "PauseLabel3D":
						node.visible = false
			elif mundo_3d.process_mode == Node.PROCESS_MODE_INHERIT:
				var nodes_3d = get_all_children(mundo_3d)
				for node in nodes_3d:
					if node.name == "Jogador3D":
						$Censura2D.global_position = Vector2(int(node.global_position.x - 412.0/2), int(node.global_position.y - 281.0/2))
					if node.name == "PauseLabel3D":
						node.visible = true
					
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
				create_tween().tween_property($Censura2D, "modulate:a", 0.67, 0.5)
				mundo_3d.process_mode = Node.PROCESS_MODE_DISABLED
	
func get_all_children(in_node,arr:=[]):
	arr.push_back(in_node)
	for child in in_node.get_children():
		arr = get_all_children(child,arr)
	return arr

func _ready() -> void:
	musica_2d.play()
	mundo_3d.visible = false
	var nodes = get_all_children(mundo_3d)
	for node in nodes:
		if node.name == "CanvasLayer":
			node.visible = false
		elif node.name == "SubViewportContainer":
			node.visible = false
	
	mundo_3d.process_mode = Node.PROCESS_MODE_DISABLED
	create_tween().tween_property($Censura2D, "modulate:a", 0, 1)

func trocar_pro_3d():
	create_tween().tween_property(musica_2d, "volume_db", -80, 3)
	musica_3d.play()
	
	to_no_3d = true
	mundo_2d.visible = false
	mundo_2d.process_mode = Node.PROCESS_MODE_DISABLED
	var nodes_2d = get_all_children(mundo_2d)
	for node in nodes_2d:
		if node.name == "Camera2D":
			node.enabled = false
	
	mundo_3d.process_mode = Node.PROCESS_MODE_INHERIT
	mundo_3d.visible = true
	mundo_3d.entrar()
	var nodes = get_all_children(mundo_3d)
	for node in nodes:
		if node.name == "CanvasLayer":
			node.visible = true
		elif node.name == "SubViewportContainer":
			node.set_deferred("visible", true)

var ganhei = false
func fim():
	ganhei = true
	to_no_3d = false
	mundo_3d.visible = false
	var nodes = get_all_children(mundo_3d)
	for node in nodes:
		if node.name == "CanvasLayer":
			node.visible = false
		elif node.name == "SubViewportContainer":
			node.visible = false
	
	mundo_3d.process_mode = Node.PROCESS_MODE_DISABLED
	
	mundo_2d.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	#mundo_2d.process_mode = Node.PROCESS_MODE_INHERIT
	var nodes_2d = get_all_children(mundo_2d)
	for node in nodes_2d:
		if node.name == "Camera2D":
			node.enabled = true
			
	create_tween().tween_property($Censura2D, "modulate:a", 0.67, 0.5)
	create_tween().tween_property(musica_2d, "volume_db", -20, 2)
	create_tween().tween_property(musica_3d, "volume_db", -80, 2)
	
	var venceu_label = get_tree().get_first_node_in_group("VenceuLabel")
	if venceu_label != null:
		venceu_label.visible = true
