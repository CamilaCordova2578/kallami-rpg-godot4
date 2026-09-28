extends Control

var nivel_maximo_desbloqueado: int = 1

@onready var btn_nivel_1 = $BtnNivel1
@onready var btn_nivel_2 = $BtnNivel2
@onready var btn_nivel_3 = $BtnNivel3
@onready var btn_volver = $BtnVolver

@onready var candado_2 = $BtnNivel2/Candado
@onready var candado_3 = $BtnNivel3/Candado

func _ready():
	Global.mostrar_hud = false
	print("--- INICIANDO PANTALLA DE MAPA ---")
	print("Nodos encontrados: ", btn_nivel_1.name, ", ", btn_volver.name)
	
	# Conectamos las señales
	btn_nivel_1.pressed.connect(_on_btn_nivel_1_pressed)
	btn_nivel_2.pressed.connect(_on_btn_nivel_2_pressed)
	btn_nivel_3.pressed.connect(_on_btn_nivel_3_pressed)
	btn_volver.pressed.connect(_on_btn_volver_pressed)
	print("Todas las señales conectadas correctamente.")
	
	actualizar_candados()

func actualizar_candados():
	print("Actualizando bloqueos. Nivel actual: ", nivel_maximo_desbloqueado)
	# Lógica para el Nivel 2
	if nivel_maximo_desbloqueado >= 2:
		btn_nivel_2.disabled = false
		candado_2.visible = false
	else:
		btn_nivel_2.disabled = true
		candado_2.visible = true
		
	# Lógica para el Nivel 3
	if nivel_maximo_desbloqueado >= 3:
		btn_nivel_3.disabled = false
		candado_3.visible = false
	else:
		btn_nivel_3.disabled = true
		candado_3.visible = true

func _on_btn_nivel_1_pressed():
	print(">>> CLIC DETECTADO: Botón Nivel 1")
	var estado = get_tree().change_scene_to_file("res://escenas/niveles/nivel_1_1.tscn")
	print("Resultado de cargar Nivel 1 (0 es Éxito): ", estado)

func _on_btn_nivel_2_pressed():
	print(">>> CLIC DETECTADO: Botón Nivel 2")
	var estado = get_tree().change_scene_to_file("res://escenas/niveles/nivel_2_1.tscn")
	print("Resultado de cargar Nivel 2 (0 es Éxito): ", estado)

func _on_btn_nivel_3_pressed():
	print(">>> CLIC DETECTADO: Botón Nivel 3")
	var estado = get_tree().change_scene_to_file("res://escenas/niveles/nivel_3.tscn")
	print("Resultado de cargar Nivel 3 (0 es Éxito): ", estado)

func _on_btn_volver_pressed():
	print(">>> CLIC DETECTADO: Botón Volver")
	var estado = get_tree().change_scene_to_file("res://escenas/menus/inicio.tscn")
	
	if estado == OK: # OK es una variable de Godot que equivale a 0
		print("ÉXITO: Viajando a la escena de inicio...")
	else:
		print("ERROR FATAL ", estado, ": No se encontró el archivo. Revisa que 'inicio.tscn' esté exactamente en esa carpeta.")
