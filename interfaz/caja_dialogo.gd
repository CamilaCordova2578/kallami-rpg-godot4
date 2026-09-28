extends CanvasLayer

# Conectamos el código con tus nodos visuales
@onready var texto_nombre = $ColorRect/TextoNombre
@onready var texto_mensaje = $ColorRect/TextoMensaje

# Aquí está tu lista de diálogos del Nivel 1 guardada en un Array
var dialogos = []

var indice_actual = 0  # Controla en qué caja de texto estamos (0, 1, 2 o 3)
var dialogo_activo = false # Evita que la tecla Enter haga cosas cuando la caja está oculta

func _ready():
	visible = false

# Ahora esta función EXIGE que le pasen una lista de textos
func iniciar_dialogo(nuevos_textos):
	dialogos = nuevos_textos
	indice_actual = 0
	texto_mensaje.text = dialogos[indice_actual]
	visible = true
	dialogo_activo = true

# Esta función detecta cuando presionas botones
func _input(event):
	# "ui_accept" por defecto es la tecla Enter o la barra Espaciadora
	if dialogo_activo and event.is_action_pressed("ui_accept"):
		avanzar_dialogo()

func avanzar_dialogo():
	indice_actual += 1 # Pasamos a la siguiente frase
	
	if indice_actual < dialogos.size():
		# Si aún quedan frases, actualizamos el texto en la pantalla
		texto_mensaje.text = dialogos[indice_actual]
	else:
		# Si ya no quedan frases, cerramos la caja
		terminar_dialogo()

func terminar_dialogo():
	visible = false
	dialogo_activo = false
