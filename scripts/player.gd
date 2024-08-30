extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var can_double_jump = false
var just_jumped = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_floor():
		just_jumped = false

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		can_double_jump = true
		just_jumped = true
		
	elif Input.is_action_just_pressed("ui_accept") and not is_on_floor() and not just_jumped:
		velocity.y = JUMP_VELOCITY
		can_double_jump = true
		just_jumped = true
		
	elif Input.is_action_just_pressed("ui_accept") and not is_on_floor() and can_double_jump:
		velocity.y = JUMP_VELOCITY
		can_double_jump = false
		just_jumped = true
		
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
