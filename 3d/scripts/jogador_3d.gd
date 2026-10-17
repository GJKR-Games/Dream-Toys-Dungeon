extends CharacterBody3D


const VELOCIDADE = 5.0
const MOUSE_SENSIBILIDADE = 1.0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * MOUSE_SENSIBILIDADE
	else:
		if Input.is_key_pressed(KEY_ESCAPE):
			get_tree().quit()

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
