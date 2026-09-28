extends CanvasLayer

@onready var icono_bombo = $HBoxContainer/IconoBombo
@onready var icono_coca = $HBoxContainer/IconoCoca
@onready var icono_alcohol = $HBoxContainer/IconoAlcohol
@onready var icono_kantuta = $HBoxContainer/IconoKantuta

func _process(delta: float) -> void:
	# 1. Enciende o apaga TODA la interfaz (el CanvasLayer completo)
	self.visible = Global.mostrar_hud
	
	# 2. Si el HUD está invisible, detenemos el código aquí para optimizar el juego
	if not self.visible:
		return
		
	# 3. Si está visible, actualizamos los ítems normalmente
	icono_bombo.visible = Global.tiene_bombo
	icono_coca.visible = Global.tiene_coca
	icono_alcohol.visible = Global.tiene_alcohol
	icono_kantuta.visible = Global.tiene_kantuta
