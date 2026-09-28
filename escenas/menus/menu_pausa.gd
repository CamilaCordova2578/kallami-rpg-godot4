extends CanvasLayer

# 1. Cargamos la escena de ajustes (asegúrate de que esta ruta sea correcta)
const AJUSTES_ESCENA = preload("res://escenas/menus/ajustes.tscn")
@onready var btn_reanudar = $ContenedorCentral/ContenedorBotones/BtnReanudar
@onready var btn_ajustes = $ContenedorCentral/ContenedorBotones/BtnAjustes
@onready var btn_salir = $ContenedorCentral/ContenedorBotones/BtnSalir

func _ready():
	# El menú debe estar oculto al iniciar el nivel
	hide()
	
	btn_reanudar.pressed.connect(_on_reanudar_pressed)
	btn_ajustes.pressed.connect(_on_ajustes_pressed)
	btn_salir.pressed.connect(_on_salir_pressed)

func _input(event):
	# "ui_cancel" es la tecla ESC por defecto en Godot
	if event.is_action_pressed("ui_cancel"):
		toggle_pausa()

func toggle_pausa():
	var esta_pausado = get_tree().paused
	
	if esta_pausado:
		# Si está pausado, reanudamos el juego y ocultamos el menú
		get_tree().paused = false
		hide()
	else:
		# Si estamos jugando, congelamos el juego y mostramos el menú
		get_tree().paused = true
		show()

func _on_reanudar_pressed():
	toggle_pausa()

func _on_ajustes_pressed():
	# 2. Creamos una instancia (copia) del menú de ajustes
	var menu_ajustes = AJUSTES_ESCENA.instantiate()
	
	# 3. Le avisamos que está abriéndose desde la pausa
	menu_ajustes.desde_pausa = true
	
	# 4. Conectamos la señal que creamos para saber cuándo el jugador presiona "Volver"
	menu_ajustes.cerrar_ajustes.connect(_on_ajustes_cerrados)
	
	# 5. Lo añadimos a la pantalla de pausa
	add_child(menu_ajustes)
	
	# 6. Ocultamos los botones de pausa para que no se encimen con los ajustes
	$ContenedorCentral.hide()

func _on_ajustes_cerrados():
	# 7. Cuando ajustes se destruye a sí mismo, volvemos a mostrar los botones de pausa
	$ContenedorCentral.show()

func _on_salir_pressed():
	get_tree().paused = false 
	get_tree().change_scene_to_file("res://escenas/menus/inicio.tscn")
