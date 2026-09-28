extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "tamborista":
		Global.tiene_alcohol = true
		print("¡Alcohol recuperado!")
		queue_free()
