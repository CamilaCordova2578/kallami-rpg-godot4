extends Control

@onready var btn_jugar = $ContenedorBotones/BtnJugar
@onready var btn_niveles = $ContenedorBotones/BtnNiveles
@onready var btn_ajustes = $ContenedorBotones/BtnAjustes
@onready var btn_salir = $ContenedorBotones/BtnSalir
@onready var musica_inicio = $MusicaInicio

func _ready():
	
	Global.mostrar_hud = false 
	# 1. ¡LIMPIEZA GENERAL DE VARIABLES!
	Global.reiniciar_partida()
	
	# Conectamos las señales de los 4 botones
	btn_jugar.pressed.connect(_on_btn_jugar_pressed)
	btn_niveles.pressed.connect(_on_btn_niveles_pressed)
	btn_ajustes.pressed.connect(_on_btn_ajustes_pressed)
	btn_salir.pressed.connect(_on_btn_salir_pressed)

func _on_btn_jugar_pressed():
	musica_inicio.stop()
	# Al darle a Jugar, asumimos que va directo al nivel 1 o a la introducción
	get_tree().change_scene_to_file("res://escenas/niveles/nivel_1_1.tscn")

func _on_btn_niveles_pressed():
	# Lleva a la pantalla del mapa (Sprint 2)
	get_tree().change_scene_to_file("res://escenas/menus/seleccion_niveles.tscn")

func _on_btn_ajustes_pressed():
	# Lleva a la pantalla de configuración de audio (Sprint 3)
	get_tree().change_scene_to_file("res://escenas/menus/ajustes.tscn")

func _on_btn_salir_pressed():
	# Cierra el juego
	# Nota: Si exportas a Web (HTML5), esta función a veces es bloqueada por el navegador.
	# En PC descargable, funciona perfectamente cerrando la ventana.
	get_tree().quit()
