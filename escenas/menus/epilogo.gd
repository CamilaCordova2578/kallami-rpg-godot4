extends Control

# Referencias a los nodos
@onready var texto_izquierdo = $Libro/TextoIzquierdo
@onready var texto_derecho = $Libro/TextoDerecho
@onready var btn_avanzar = $BtnAvanzar
#@onready var musica_epilogo = $MusicaEpilogo

func _ready():
	# Apagamos el HUD global limpiamente
	Global.mostrar_hud = false
	
	# 1. Ocultamos el botón al inicio para que el jugador se concentre en leer
	btn_avanzar.visible = false
	
	# 2. Inyectamos el texto (Exactamente 18 y 21 palabras)
	texto_izquierdo.text = "El imponente cerro Kallami, antes una prision de piedra, finalmente escucho nuestra ofrenda y calmo su antigua furia."
	texto_derecho.text = "Los musicos atrapados fueron liberados de su letargo. Hoy, el eco de sus melodias andinas resuena eternamente como simbolo de consenso."
	
	# 3. Hacemos que los textos comiencen invisibles
	texto_izquierdo.visible_ratio = 0.0
	texto_derecho.visible_ratio = 0.0
	
	# 4. Iniciamos la magia de la narración
	mostrar_historia()
	
	# 5. Conectamos el botón para cuando aparezca
	btn_avanzar.pressed.connect(_on_btn_avanzar_pressed)

func mostrar_historia():
	var tween = create_tween()
	
	# Tiempo que tarda en escribirse cada página
	var tiempo_pagina = 4.0 
	
	# Paso 1: Escribir página izquierda
	tween.tween_property(texto_izquierdo, "visible_ratio", 1.0, tiempo_pagina)
	
	# Paso 2: Pequeña pausa dramática de 1 segundo para que el jugador respire
	tween.tween_interval(1.0)
	
	# Paso 3: Escribir página derecha
	tween.tween_property(texto_derecho, "visible_ratio", 1.0, tiempo_pagina)
	
	# Paso 4: Cuando la animación del texto termina, llamamos a una función para mostrar el botón
	tween.finished.connect(_mostrar_boton_salida)

func _mostrar_boton_salida():
	# El texto terminó, ¡ahora sí dejamos que el jugador avance!
	btn_avanzar.visible = true

func _on_btn_avanzar_pressed():
	#musica_epilogo.stop()
	# Nos vamos a la última pantalla del juego: Los Créditos
	get_tree().change_scene_to_file("res://escenas/menus/creditos.tscn")
