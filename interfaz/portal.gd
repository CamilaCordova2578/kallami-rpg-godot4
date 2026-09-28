extends Area2D

@export_file("*.tscn") var ruta_siguiente_nivel: String

@export_group("Castigo del Achachila")
# Esta variable nos dejará elegir el Marker2D desde el Inspector
@export var punto_respawn: Marker2D 

@export_group("Requisitos de Paso")
@export var requiere_bombo: bool = false
@export var requiere_coca: bool = false
@export var requiere_alcohol: bool = false
@export var requiere_kantuta: bool = false

@export_group("Ritual Final")
@export var es_altar_final: bool = false

func _on_body_entered(body: Node2D) -> void:
	print("ALGO TOCÓ EL PORTAL: ", body.name)
	
	if body.name.to_lower() == "tamborista":
		
		# Agrupamos las faltas: Si falta CUALQUIER cosa requerida, se activa el castigo
		if (requiere_bombo and not Global.tiene_bombo) or \
		   (requiere_coca and not Global.tiene_coca) or \
		   (requiere_alcohol and not Global.tiene_alcohol) or \
		   (requiere_kantuta and not Global.tiene_kantuta):
			
			print("El Achachila rechaza tu paso. Te falta parte de la ofrenda.")
			
			# Si asignamos un punto de respawn, teletransportamos al jugador allí
			if punto_respawn != null:
				body.global_position = punto_respawn.global_position
			else:
				print("Error: Olvidaste asignar el Marker2D de respawn en el Inspector del portal.")
				
			return # Cortamos la función para que no cambie de nivel

		# Si el jugador tiene toda la ofrenda, verificamos si es el altar
		if es_altar_final:
			print("¡El rito comienza! Congelando al Tamborista...")
			
			# Le decimos al jugador que se detenga
			if body.has_method("iniciar_ritual"):
				body.iniciar_ritual()
			
			# --- Conexión con el cerebro rítmico ---
			var manager = get_tree().current_scene.get_node_or_null("RitualManager")
			if manager != null:
				manager.preparar_ritual() 
			else:
				print("Error: No se encontró el RitualManager en la escena.")
			
		else:
			# Si NO es el altar final, funciona como un portal normal
			if ruta_siguiente_nivel != "":
				get_tree().call_deferred("change_scene_to_file", ruta_siguiente_nivel)
