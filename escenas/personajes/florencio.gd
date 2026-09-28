extends CharacterBody2D

var jugador_en_zona = false

# Paquete 1: El guion original
var dialogos_iniciales = [
	"Muchacho... menos mal que saliste con vida. Tus compañeros subieron a Kallami sin pedir permiso al Achachila.",
	"El cerro no perdona la soberbia. Ahora los tienes atrapados adentro, tocando un eco que ya nadie más escucha.",
	"Pero tú dejaste caer tu bombo aquí mismo, en la plaza. Búscalo primero: sin tu tambor no hay manera de hablarle a la montaña.",
	"Después, sube al sendero y reúne la ofrenda. Ve con respeto."
]

# Paquete 2: El tutorial
var dialogos_tutorial = [
	"¡Ah, recuperaste tu tambor! El corazón de la ofrenda.",
	"Recuerda: el ritmo y la música calman a la montaña.",
	"Presiona la tecla ESPACIO cuando estés frente al altar para iniciar el rito."
]

func _on_zona_dialogo_body_entered(body: Node2D) -> void:
	if body.name == "Tamborista": 
		jugador_en_zona = true

func _on_zona_dialogo_body_exited(body: Node2D) -> void:
	if body.name == "Tamborista":
		jugador_en_zona = false

func _input(event):
	if jugador_en_zona and event.is_action_pressed("ui_accept"):
		var caja = get_parent().get_node_or_null("CajaDialogo")
		
		if caja != null and caja.dialogo_activo == false:
			# LA MÁQUINA DE ESTADOS:
			if Global.tiene_bombo == false:
				caja.iniciar_dialogo(dialogos_iniciales)
			else:
				caja.iniciar_dialogo(dialogos_tutorial)
