extends Area2D

func _on_body_entered(body: Node2D) -> void:
	# Convertimos a minúsculas por seguridad, igual que en el portal
	if body.name.to_lower() == "tamborista":
		
		# Calculamos el vector: hacia dónde debe rebotar el jugador
		# Restamos la posición de la cactácea de la posición del jugador
		var direccion_rebote = (body.global_position - global_position).normalized()
		
		# Llamamos a la nueva función del jugador, enviándole la dirección
		if body.has_method("aplicar_empuje"):
			body.aplicar_empuje(direccion_rebote)
