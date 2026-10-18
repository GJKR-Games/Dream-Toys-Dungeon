extends Node

@onready var mundo_3d = $Mundo3D
@onready var mundo_2d = $Mundo2D
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
	
	mundo_3d.process_mode = Node.PROCESS_MODE_DISABLED
	create_tween().tween_property($Censura2D, "modulate:a", 0, 1)

func trocar_pro_3d():
	mundo_2d.visible = false
	mundo_2d.process_mode = Node.PROCESS_MODE_DISABLED
	
	mundo_3d.process_mode = Node.PROCESS_MODE_INHERIT
	mundo_3d.visible = true
	mundo_3d.entrar()
	var nodes = get_all_children(mundo_3d)
	for node in nodes:
		if node.name == "CanvasLayer":
			node.visible = true
	
