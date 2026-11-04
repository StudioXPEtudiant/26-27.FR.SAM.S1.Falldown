extends CharacterBody3D

class_name MainPlayerScript

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
		"J" + str(_GetNumPlayer()) + "_Left",
		"J" + str(_GetNumPlayer()) + "_Right"
	)

	var verticalAxe = Input.get_axis(
		"J" + str(_GetNumPlayer()) + "_Down",
		"J" + str(_GetNumPlayer()) + "_Up"
	)

	var direction = Vector3(horizontalAxe, 0, -verticalAxe).normalized()

	if direction != Vector3.ZERO:
		var target_angle = atan2(direction.x, direction.z)
		rotation.y = lerp_angle(rotation.y, target_angle, 5.0 * delta)

	velocity.x = direction.x * moveSpeed
	velocity.z = direction.z * moveSpeed

	if not is_on_floor():
		velocity.y -= ProjectSettings.get_setting("physics/3d/default_gravity") * delta
	else:
		velocity.y = 0

	move_and_slide()
