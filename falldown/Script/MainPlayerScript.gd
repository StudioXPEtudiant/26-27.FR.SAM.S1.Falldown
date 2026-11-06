extends CharacterBody3D

class_name MainPlayerScript

@export var camera: Camera3D
@export var moveSpeed:float = 5
@export var numPlayer:int = 1
@export var jumpPrecision:float = 1

var externalImpulse:Vector3

func _GetNumPlayer() -> int:
	return numPlayer

func addImpulse(impulse:Vector3):
	externalImpulse += impulse

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):

	var horizontalAxe = Input.get_axis(
		"J" + str(_GetNumPlayer()) + "_Right",
		"J" + str(_GetNumPlayer()) + "_Left"
	)

	var verticalAxe = Input.get_axis(
		"J" + str(_GetNumPlayer()) + "_Up",
		"J" + str(_GetNumPlayer()) + "_Down"
	)

	# Direction de la caméra
	var camera_forward = -camera.global_basis.z

	camera_forward.y = 0
	camera_forward = camera_forward.normalized()

	var camera_right = Vector3(
		-camera_forward.z,
		0,
		camera_forward.x
	).normalized()

	# Direction du déplacement
	var direction = (
		camera_right * horizontalAxe +
		camera_forward * verticalAxe
	).normalized()

	# Faire tourner le personnage vers son déplacement
	if direction.length_squared() > 0.001:

		var target_angle = atan2(
			-direction.x,
			-direction.z
		) + PI

		rotation.y = lerp_angle(
			rotation.y,
 			target_angle,
 			minf(8.0 * delta, 1.0)
 		)

	# Déplacement
	velocity.x = direction.x * moveSpeed
	velocity.z = direction.z * moveSpeed

	# Gravité
	if not is_on_floor():
		velocity.y -= ProjectSettings.get_setting(
			"physics/3d/default_gravity"
		) * delta
	else:
		velocity.y = 0

	move_and_slide()
