extends Node
var mostrar_hud: bool = false
var tiene_bombo = false
var tiene_coca = false
var tiene_alcohol = false
var tiene_kantuta = false

# En Global.gd, añade esto al final:

func reiniciar_partida():
	tiene_bombo = false
	tiene_coca = false
	tiene_alcohol = false
	tiene_kantuta = false
