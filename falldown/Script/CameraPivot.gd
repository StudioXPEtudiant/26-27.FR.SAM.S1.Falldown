extends Node3D

@export var target: Node3D
@export var cameraSpeed: float = 2.0
@export var followHeight: float = 1.5

var yaw: float = 0.0
var pitch: float = deg_to_rad(-15.0)

func _ready():
	top_level = true

	if target != null:
		global_position = target.global_position + Vector3.UP * followHeight

	yaw = rotation.y
	global_rotation = Vector3(pitch, yaw, 0)


func _process(delta):

	if target == null:
		return

	# Suivre le personnage
	global_position = target.global_position + Vector3.UP * followHeight

	# Rotation horizontale
	if Input.is_action_pressed("CamRight"):
		yaw -= cameraSpeed * delta

	if Input.is_action_pressed("CamLeft"):
		yaw += cameraSpeed * delta

	# Rotation verticale
	if Input.is_action_pressed("CamUp"):
		pitch += cameraSpeed * delta

	if Input.is_action_pressed("CamDown"):
		pitch -= cameraSpeed * delta

	# Limiter la rotation verticale
	pitch = clampf(
		pitch,
		deg_to_rad(-60),
		deg_to_rad(20)
	)

	global_rotation = Vector3(pitch, yaw, 0)
