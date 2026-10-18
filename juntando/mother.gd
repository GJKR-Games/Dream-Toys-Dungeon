extends Node

@onready var mundo_3d = $Mundo3D
@onready var mundo_2d = $Mundo2D
var to_no_3d = false

func _input(event: InputEvent) -> void:
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
			
			pass
	
func get_all_children(in_node,arr:=[]):
	arr.push_back(in_node)
	for child in in_node.get_children():
		arr = get_all_children(child,arr)
	return arr

func _ready() -> void:
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
			#node.visible = true
			node.set_deferred("visible", true)
	
