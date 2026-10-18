extends CharacterBody3D


const VELOCIDADE = 5.0
const MOUSE_SENSIBILIDADE = 0.1
var posso_tomar_hit = true
var coletados: int = 0
@export var world: WorldEnvironment


func add_coletado():
	coletados += 1
	var coleta_label: Label = get_tree().get_first_node_in_group("ColetaLabel")
	if coleta_label != null:
		coleta_label.text = "Coletados: %s/4" % coletados

	if coletados == 4:
		var mother: Node = get_tree().get_first_node_in_group("mother")
		mother.fim()

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * MOUSE_SENSIBILIDADE
	


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * VELOCIDADE
		velocity.z = direction.z * VELOCIDADE
	else:
		velocity.x = move_toward(velocity.x, 0, VELOCIDADE)
		velocity.z = move_toward(velocity.z, 0, VELOCIDADE)

	move_and_slide()

func tomar_hit():
	if posso_tomar_hit:
		var tween = create_tween()
		
		posso_tomar_hit = false
		get_tree().create_timer(1.2).timeout.connect(func(): posso_tomar_hit = true)
		world.environment.adjustment_saturation = 0
		world.environment.adjustment_brightness = 0.4
		
		tween.tween_property(world, "environment:adjustment_saturation", 1, 1)
		tween.tween_property(world, "environment:adjustment_brightness", 1, 2)
