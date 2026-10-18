class_name Inimigo3D
extends CharacterBody3D

@onready var animated_sprite = $AnimatedSprite3D

var move_speed = 2.5
var attack_range = 2.0

var to_morto = false

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player3d")
@onready var animation = $Animation

var lado_incial = false
func _ready() -> void:
	lado_incial = randi() % 2

func iniciar_animacoes():
	animation.connect("animation_finished", resetar_animacao)
	if lado_incial:
		animation.play("idle")
	else:
		animation.play("idle_2")

func resetar_animacao(animacao):
	if not to_morto:
		if animacao == "idle":
			animation.play("idle_2")
		if animacao == "idle_2":
			animation.play("idle")

var detectei = false

func _physics_process(_delta: float) -> void:
	if to_morto: return
	if not detectei: return
	if player == null:
		print("PLAYER NULO???")
		player = get_tree().get_first_node_in_group("player3d")
		return
	
	var dir = player.global_position - global_position
	dir.y = 0.0
	dir = dir.normalized()
	velocity = dir * move_speed
	move_and_slide()


func morte():
	to_morto = true
	$AudioMorte.play()
	animation.stop()
	animated_sprite.play("morto")
	$CollisionShape3D.disabled = true
	$AttackRange/CollisionShape3D.disabled = true

	
func _on_attack_range_body_entered(body: Node3D) -> void:
	if not to_morto and body.name == "Jogador3D":
		player.tomar_hit()


var iniciei_andamento = false
func _on_area_deteccao_body_entered(body: Node3D) -> void:
	if body.name == "Jogador3D" and not iniciei_andamento and not to_morto:
		iniciar_animacoes()
		iniciei_andamento = true
		$AnimatedSprite3D.play("andar")
		detectei = true
