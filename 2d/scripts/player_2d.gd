extends CharacterBody2D


const SPEED = 100.0

# Controles de Animação
@onready var animated_sprite_2d: AnimatedSprite2D = $SpritePlayer
enum AnimState {IDLE_D, IDLE_U, IDLE_S, WALKING_D, WALKING_U, WALKING_S}

var state = AnimState.IDLE_D


func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
	if Input.is_action_just_pressed("ui_interact") and to_na_area:
		var mother = get_tree().get_first_node_in_group("mother")
		if mother == null:
			print('err')
		else:
			mother.trocar_pro_3d()

func _physics_process(_delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX := Input.get_axis("ui_left", "ui_right")
	var directionY := Input.get_axis("ui_up", "ui_down")
	if directionX:
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	
	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	# Handle animation
	if (directionX):
		handle_animationX(directionX)
	elif (directionY):
		handle_animationY(directionY)
	else:
		animated_sprite_2d.play("idle")
	move_and_slide()
	
func handle_animationX(directionX):
	directionX = directionX;
	if(directionX > 0):
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("walking");
	elif(directionX < 0):
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("walking")

func handle_animationY(directionY):
	directionY = directionY;
	if(directionY > 0):
		animated_sprite_2d.play("walking_down")
	elif(directionY < 0):
		animated_sprite_2d.play("walking_top")

func change_state(new_state):
	state = new_state


var to_na_area = false
func _on_area_2d_area_entered(area: Area2D) -> void:
	to_na_area = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	to_na_area = false
