extends Area2D

@export var objetivo: int
@export var destino: PackedScene
func _process(delta):
	pass



func _on_body_entered(body):
	if body.is_in_group("players"):
		var score = %GameManager.score
		print(score)
		if score >= objetivo:
			get_tree().change_scene_to_packed(destino)
