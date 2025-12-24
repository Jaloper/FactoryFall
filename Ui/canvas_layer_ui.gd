extends CanvasLayer



const CORAZON_LLENO = preload("res://assets/PNG/corazon_lleno.png")

const CORAZON_VACIO = preload("res://assets/PNG/corazon_vacio.png")



func _on_game_controller_player_health_updated(new_player_health: Variant) -> void:
	$HBoxContainer/TextureRect.texture = CORAZON_LLENO if new_player_health >= 1 else CORAZON_VACIO
	$HBoxContainer/TextureRect2.texture = CORAZON_LLENO if new_player_health >= 2 else CORAZON_VACIO
	$HBoxContainer/TextureRect3.texture = CORAZON_LLENO if new_player_health >= 3 else CORAZON_VACIO


func _on_game_controller_time_updated(tiempo_restante: Variant) -> void:
	$TextureRect/Label.text=str(tiempo_restante)
