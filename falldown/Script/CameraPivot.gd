extends Node3D

@export var target: Node3D
@export var cameraSpeed: float = 2.0
@export var followHeight: float = 1.5
@export var mouseSensitivity: float = 0.005

var yaw: float = 0.0
var pitch: float = deg_to_rad(-15.0)
var dragging_mouse: bool = false


func _ready():
	top_level = true

	yaw = global_rotation.y

	if target != null:
		global_position = target.global_position + Vector3.UP * followHeight

	global_rotation = Vector3(pitch, yaw, 0)


# Gestion de la souris
func _input(event):

	# Clic droit maintenu
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:

			dragging_mouse = event.pressed

			if dragging_mouse:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			else:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	# Mouvement de la souris
	if event is InputEventMouseMotion and dragging_mouse:

		yaw -= event.relative.x * mouseSensitivity

		pitch += event.relative.y * mouseSensitivity

		pitch = clampf(
			pitch,
			deg_to_rad(-60),
			deg_to_rad(20)
		)


# Suivi et rotation de la caméra
func _process(delta):

	if target == null:
		return

	# Suivre le personnage
	global_position = target.global_position + Vector3.UP * followHeight

	# Garder les commandes clavier existantes
	if Input.is_action_pressed("CamRight"):
		yaw -= cameraSpeed * delta

	if Input.is_action_pressed("CamLeft"):
		yaw += cameraSpeed * delta

	if Input.is_action_pressed("CamUp"):
		pitch += cameraSpeed * delta

	if Input.is_action_pressed("CamDown"):
		pitch -= cameraSpeed * delta

	pitch = clampf(
		pitch,
		deg_to_rad(-60),
		deg_to_rad(20)
	)

	global_rotation = Vector3(pitch, yaw, 0)


func _exit_tree():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
