extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var spawn_arrow = preload("res://Scenes/Objects/arrow.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var mouse_pos = get_local_mouse_position()
	if mouse_pos.x < 0 && scale.x > 0:
		scale.x = -1
	elif mouse_pos.x > 0 && scale.x < 0:
		scale.x = 1
	
	$Arrow_Spawn.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("Left_Mouse"):
		var init_arrow = spawn_arrow.instantiate() as RigidBody2D
		init_arrow.position = $Arrow_Spawn.global_position
		init_arrow.rotation = $Arrow_Spawn.global_rotation
		var spawn_direction : Vector2 = $Arrow_Spawn.global_position - get_global_mouse_position()
		print()
		init_arrow.linear_velocity = spawn_direction.normalized() * 100 * -1 
		get_parent().add_child(init_arrow)

	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
