extends Area3D

@export_file("*.tscn") var next_scene: String

var changing_scene = false


func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body):

	if changing_scene:
		return

	if body is CharacterBody3D:

		changing_scene = true

		if next_scene.is_empty():
			push_warning("Aucune scène de destination sélectionnée.")
			changing_scene = false
			return

		get_tree().call_deferred("change_scene_to_file", next_scene)
