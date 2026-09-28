extends Node

@export_group("UI del Ritual")
@export var ui_ritual: CanvasLayer
@export var barra_ritmo: TextureRect
@export var caja_dialogo: TextureRect
@export var texto_mensaje: Label
@export var rombos: Array[TextureRect]
@export var tex_apagado: Texture2D
@export var tex_prendido: Texture2D

@export_group("Castigos y Físicas")
@export var jugador: CharacterBody2D
@export var punto_reaparicion: Marker2D
@export var intentos_maximos: int = 3
@export_file("*.tscn") var ruta_game_over: String
@export_file("*.tscn") var ruta_victoria: String

@export_group("Audio")
@export var sfx_error: AudioStreamPlayer
@export var sfx_bombo: AudioStreamPlayer

# Secuencia con las nuevas notas separadas del movimiento
var secuencia_secreta: Array[String] = ["nota_1", "nota_2", "nota_3", "nota_4", "ui_accept"]

var paso_actual: int = 0
var ritual_activo: bool = false
var esperando_inicio: bool = false
var intentos_actuales: int = 3

func _ready() -> void:
	if ui_ritual != null:
		ui_ritual.visible = false
		barra_ritmo.visible = false
		caja_dialogo.visible = false

	intentos_actuales = intentos_maximos

func preparar_ritual() -> void:
	esperando_inicio = true

	if ui_ritual != null:
		ui_ritual.visible = true
		caja_dialogo.visible = true

		# --- DIÁLOGO INTELIGENTE ---
		if intentos_actuales == intentos_maximos:
			texto_mensaje.text = "El Tamborista está en posición.\nPresiona ENTER para iniciar la melodía."
		else:
			texto_mensaje.text = "El eco te observa. Tienes " + str(intentos_actuales) + " intentos.\nPresiona ENTER para tocar."

func iniciar_minijuego() -> void:
	esperando_inicio = false
	ritual_activo = true
	paso_actual = 0

	if barra_ritmo != null:
		barra_ritmo.visible = true

	_reiniciar_rombos()

	texto_mensaje.text = "¡El eco despierta!\nToca la primera nota..."

func _input(event: InputEvent) -> void:
	# Si está en el altar esperando para iniciar
	if esperando_inicio and event.is_action_pressed("ui_accept"):
		iniciar_minijuego()
		return

	if not ritual_activo:
		return

	# Lógica del minijuego con las NUEVAS TECLAS
	if event is InputEventKey and event.is_pressed() and not event.is_echo():

		if event.is_action_pressed(secuencia_secreta[paso_actual]):
			_acierto()

		else:
			# Escuchamos los errores solo si presiona una nota incorrecta
			if event.is_action("nota_1") \
			or event.is_action("nota_2") \
			or event.is_action("nota_3") \
			or event.is_action("nota_4") \
			or event.is_action("ui_accept"):

				_fallo()

func _acierto() -> void:
	if rombos.size() > paso_actual:
		rombos[paso_actual].texture = tex_prendido

	paso_actual += 1

	texto_mensaje.text = "¡Acierto!\nHas tocado " + str(paso_actual) + " de 5 notas."

	if sfx_bombo != null:
		sfx_bombo.play()

	if paso_actual >= secuencia_secreta.size():
		_victoria()

func _fallo() -> void:
	ritual_activo = false
	paso_actual = 0
	_reiniciar_rombos()

	intentos_actuales -= 1

	# Sonido de error
	if sfx_error != null:
		sfx_error.play()

	if intentos_actuales > 0:

		# --- CASTIGO INMEDIATO ---
		if ui_ritual != null:
			ui_ritual.visible = false

		if caja_dialogo != null:
			caja_dialogo.visible = false

		if barra_ritmo != null:
			barra_ritmo.visible = false

		esperando_inicio = false

		# Teletransportamos al jugador inmediatamente
		if jugador != null and punto_reaparicion != null:
			jugador.global_position = punto_reaparicion.global_position

		# Le devolvemos el movimiento al jugador
		if jugador != null and jugador.has_method("terminar_ritual"):
			jugador.terminar_ritual()

	else:

		# --- GAME OVER ---
		texto_mensaje.text = "¡DISONANCIA FATAL!\nLa montaña ha despertado su furia..."

		if ui_ritual != null:
			ui_ritual.visible = true

		if caja_dialogo != null:
			caja_dialogo.visible = true

		if barra_ritmo != null:
			barra_ritmo.visible = false

		_ejecutar_game_over()

func _ejecutar_game_over() -> void:
	print("Llevando a la pantalla de Game Over...")

	if ruta_game_over != "":
		get_tree().change_scene_to_file(ruta_game_over)
	else:
		print("Error: No asignaste la escena de Game Over en el Inspector.")

func _victoria() -> void:
	ritual_activo = false

	texto_mensaje.text = "¡ARMONÍA PERFECTA!\nEl Achachila acepta la ofrenda."
	
	# Pausa de 1.5 segundos para que el jugador lea el mensaje y vea el último rombo encendido
	await get_tree().create_timer(1.5).timeout
	
	_ejecutar_victoria()

func _ejecutar_victoria() -> void:
	print("Llevando a la pantalla de Victoria...")
	
	if ruta_victoria != "":
		get_tree().change_scene_to_file(ruta_victoria)
	else:
		print("Error: No asignaste la escena de Victoria en el Inspector.")

func _reiniciar_rombos() -> void:
	for rombo in rombos:
		if rombo != null:
			rombo.texture = tex_apagado
