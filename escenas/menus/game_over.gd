extends Control

@onready var btn_reintentar = $ContenedorBotones/BtnReintentar
@onready var btn_inicio = $ContenedorBotones/BtnInicio
@onready var texto_derrota = $CajaDialogo/Texto
@onready var musica_game_over = $MusicaGameOver

func _ready():
	
	Global.mostrar_hud = false
	
	# Texto narrativo de fracaso
	texto_derrota.text = "El Achachila ha rechazado la ofrenda...\nLa disonancia domina la caverna y los musicos caen exhaustos."
	
	# Efecto máquina de escribir
	texto_derrota.visible_ratio = 0.0
	var tween = create_tween()
	tween.tween_property(texto_derrota, "visible_ratio", 1.0, 4.0)
	
	# Conectar señales de los botones
	btn_reintentar.pressed.connect(_on_btn_reintentar_pressed)
	btn_inicio.pressed.connect(_on_btn_inicio_pressed)

func _on_btn_reintentar_pressed():
	musica_game_over.stop()
	# ATENCIÓN: Cambia "nivel_1.tscn" por el nombre exacto de tu escena del nivel
	get_tree().change_scene_to_file("res://escenas/niveles/nivel_1_1.tscn")

func _on_btn_inicio_pressed():
	musica_game_over.stop()
	# Volvemos a la pantalla principal
	get_tree().change_scene_to_file("res://escenas/menus/inicio.tscn")
