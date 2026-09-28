extends Control

@onready var btn_leyenda = $ContenedorBotones/BtnLeyenda
@onready var btn_avanzar = $ContenedorBotones/BtnAvanzar
# Asegúrate de que este nombre ("Texto") coincida con cómo llamaste a tu nodo RichTextLabel
@onready var texto_leyenda = $CajaDialogo/Texto 

func _ready():
	Global.mostrar_hud = false 
	# 1. Le inyectamos el texto exacto por código para asegurar que no esté vacío
	texto_leyenda.text = "El cerro ha exhalado su ultimo eco...\ny la musica vuelve a fluir con el viento."
	
	# 2. Hacemos que el texto sea invisible al inicio (0.0)
	texto_leyenda.visible_ratio = 0.0
	
	# 3. Creamos la animación para que el texto aparezca en 3 segundos
	var tween = create_tween()
	tween.tween_property(texto_leyenda, "visible_ratio", 1.0, 3.0)
	
	# 4. Conectamos los botones
	btn_leyenda.pressed.connect(_on_btn_leyenda_pressed)
	btn_avanzar.pressed.connect(_on_btn_avanzar_pressed)

func _on_btn_leyenda_pressed():
	get_tree().change_scene_to_file("res://escenas/menus/epilogo.tscn")

func _on_btn_avanzar_pressed():
	get_tree().change_scene_to_file("res://escenas/inicio.tscn")
