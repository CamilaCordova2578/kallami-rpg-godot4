extends Control

@onready var texto_creditos = $TextoCreditos
@onready var btn_inicio = $BtnInicio
#@onready var musica_creditos = $MusicaCreditos

func _ready():
	
	Global.mostrar_hud = false
	# 1. Calculamos el alto de tu pantalla de juego
	var altura_pantalla = get_viewport_rect().size.y
	
	# 2. Escondemos el texto justo debajo de la pantalla para que empiece a subir desde ahí
	texto_creditos.position.y = altura_pantalla
	
	# 3. Creamos la animación de desplazamiento
	var tween = create_tween()
	
	# Calculamos hasta dónde debe subir (hasta que todo el bloque de texto salga por arriba)
	var destino_y = -texto_creditos.size.y - 50 
	
	# El '20.0' son los segundos que tardará en subir todo el texto.
	# Si lo notas muy rápido o muy lento, ajusta este número.
	tween.tween_property(texto_creditos, "position:y", destino_y, 20.0)
	
	# 4. Cuando los créditos terminen de subir, volvemos al inicio automáticamente
	tween.finished.connect(_on_btn_inicio_pressed)
	
	# 5. Por si el jugador presiona el botón de saltar créditos
	btn_inicio.pressed.connect(_on_btn_inicio_pressed)


func _on_btn_inicio_pressed():
	#musica_creditos.stop()
	# Nos vamos a la pantalla principal del juego
	get_tree().change_scene_to_file("res://escenas/menus/inicio.tscn")
