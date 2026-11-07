extends Node3D

@export var cameraSpeed=2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("CamUp"):
		rotation.x+=cameraSpeed*delta
	if Input.is_action_pressed("CamDown"):
		rotation.x-=cameraSpeed*delta
	if Input.is_action_pressed("CamRight"):
		rotation.y-=cameraSpeed*delta
	if Input.is_action_pressed("CamLeft"):
		rotation.y+=cameraSpeed*delta
	pass
