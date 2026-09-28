extends Control

# Creamos una señal personalizada para avisar al menú de pausa
signal cerrar_ajustes 
# Esta variable nos dirá si venimos del inicio o de la pausa
var desde_pausa: bool = false

@onready var btn_volver = $BtnVolver
@onready var slider_musica = $ContenedorSliders/FilaMusica/SliderMusica
@onready var slider_sfx = $ContenedorSliders/FilaSFX/SliderSFX
@onready var slider_ambiente = $ContenedorSliders/FilaAmbiente/SliderAmbiente

# Índices de los canales de audio separados
var bus_musica: int
var bus_sfx: int
var bus_ambiente: int

func _ready():
	bus_musica = AudioServer.get_bus_index("Musica")
	bus_sfx = AudioServer.get_bus_index("SFX")
	bus_ambiente = AudioServer.get_bus_index("Ambiente")

	# 1. Leer el volumen actual del servidor de audio y actualizar las barras
	slider_musica.value = db_to_linear(AudioServer.get_bus_volume_db(bus_musica))
	slider_sfx.value = db_to_linear(AudioServer.get_bus_volume_db(bus_sfx))
	slider_ambiente.value = db_to_linear(AudioServer.get_bus_volume_db(bus_ambiente))

	# 2. Conectamos las señales DESPUÉS de igualar los valores (para evitar errores)
	slider_musica.value_changed.connect(_on_musica_changed)
	slider_sfx.value_changed.connect(_on_sfx_changed)
	slider_ambiente.value_changed.connect(_on_ambiente_changed)

	btn_volver.pressed.connect(_on_btn_volver_pressed)

func _on_musica_changed(valor: float):
	# Convertimos el valor lineal (0.001 a 1.0) a Decibeles (dB)
	AudioServer.set_bus_volume_db(bus_musica, linear_to_db(valor))

func _on_sfx_changed(valor: float):
	AudioServer.set_bus_volume_db(bus_sfx, linear_to_db(valor))

func _on_ambiente_changed(valor: float):
	AudioServer.set_bus_volume_db(bus_ambiente, linear_to_db(valor))

func _on_btn_volver_pressed():
	if desde_pausa:
		# Si venimos de la pausa, emitimos la señal y destruimos este nodo (queue_free)
		cerrar_ajustes.emit()
		queue_free()
	else:
		# Si venimos del menú de inicio, cambiamos de escena normalmente
		get_tree().change_scene_to_file("res://escenas/menus/inicio.tscn")
