extends Area2D

func _on_body_entered(body):
	if body.name == "Tamborista":
		# ¡Encendemos la variable global!
		Global.tiene_bombo = true 
		print("¡Bombo recuperado!") 
		queue_free()
