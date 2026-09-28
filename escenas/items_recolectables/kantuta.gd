extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "tamborista":
		Global.tiene_kantuta = true
		print("¡Kantuta recuperada!")
		queue_free()
	
