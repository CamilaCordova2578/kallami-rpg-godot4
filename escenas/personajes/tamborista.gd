extends CharacterBody2D

const SPEED = 150.0

@onready var anim = $AnimationPlayer
@onready var sfx_pasos = $SFX_Pasos
var en_retroceso: bool = false 
var en_ritual: bool = false

func _ready():
	anim.play("caminar_arriba")
	anim.stop()

func _physics_process(_delta):
	# --- CANDADO DEL RITUAL ---
	# Si el portal activó el ritual, el personaje se congela aquí.
	if en_ritual:
		velocity = Vector2.ZERO
		anim.stop() # Evita que se quede atascado en la animación de caminar
		move_and_slide()
		return # Corta la función. Ignora las teclas de abajo.
	# --------------------------

	var direction = Vector2.ZERO

	if en_retroceso == false:
		direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	velocity = direction * SPEED
	move_and_slide()

	# --- CONTROL DE ANIMACIÓN CORREGIDO ---
	if direction != Vector2.ZERO:
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				if anim.current_animation != "caminar_der":
					anim.play("caminar_der")
			else:
				if anim.current_animation != "caminar_izq":
					anim.play("caminar_izq")
		else:
			if direction.y > 0:
				if anim.current_animation != "caminar_abajo":
					anim.play("caminar_abajo")
			else:
				if anim.current_animation != "caminar_arriba":
					anim.play("caminar_arriba")
	else:
		# Detiene la animación si el jugador no está tocando ninguna tecla
		anim.stop()
				
				
func aplicar_empuje(direccion_choque: Vector2, fuerza: float = 300.0) -> void:
	en_retroceso = true
	# Aplicamos la fuerza en la dirección contraria
	velocity = direccion_choque * fuerza
	move_and_slide()
	
	# Efecto visual: hacemos que el personaje se ponga rojo por un instante
	modulate = Color(1, 0, 0) # Rojo
	
	# Bloqueamos el control por 0.3 segundos usando un temporizador nativo
	await get_tree().create_timer(0.3).timeout
	
	# Devolvemos el control y el color original
	modulate = Color(1, 1, 1) # Blanco (normal)
	en_retroceso = false


# --- NUEVA FUNCIÓN PARA EL PORTAL ---
func iniciar_ritual() -> void:
	en_ritual = true

# --- FUNCIÓN CORREGIDA ---
func terminar_ritual() -> void:
	en_ritual = false
	# Obligamos al personaje a mirar hacia el altar al reaparecer
	anim.play("caminar_arriba")
	anim.stop()
	
# --- AUDIO DE PASOS ---
func reproducir_paso() -> void:
	if sfx_pasos != null:
		# Esto hace que el sonido varíe su volumen (pitch) un poquito
		sfx_pasos.pitch_scale = randf_range(0.8, 1.2) 
		#Silenciamos sonidos de pasos
		#sfx_pasos.play()
