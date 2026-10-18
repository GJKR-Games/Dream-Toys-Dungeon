extends Node3D

@onready var animation: AnimationPlayer = $CanvasLayer/AnimationPlayer
@onready var audio := $CanvasLayer/Audio
@onready var hitzone := $HitZone
@export var main_camera: Camera3D

var pode_atirar = true

func _ready() -> void:
	animation.play("idle")
	animation.animation_finished.connect(func(anm): if anm == "atirar": pode_atirar = true)
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and pode_atirar:
			pode_atirar = false
			audio.play()
			animation.play("atirar")
			
			testar_e_atirar()
		
func testar_e_atirar():
	var inimigos: Array[Node3D] = hitzone.get_overlapping_bodies()
	inimigos.sort_custom(func(a, b): return global_position.distance_to(a.global_position) < global_position.distance_to(b.global_position))
	
	for inimigo in inimigos:
		var result = testar_ray_cast(inimigo.global_position)
		if (result.has("collider")):
			if (result.collider == inimigo):
				print("Atirado")
				inimigo.morte()
				break
				
			else: print("nao atirado")

func testar_ray_cast(pos: Vector3) -> Dictionary:
	var space_state = get_world_3d().direct_space_state
	var origem = global_position
	var fim = pos
	var query = PhysicsRayQueryParameters3D.create(origem, fim)
	query.collide_with_areas = true
	
	return space_state.intersect_ray(query)
	
	
