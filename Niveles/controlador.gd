extends Node2D

const SCENE_FINISH_FILE = "res://ui/escena_final.tscn"

signal player_health_updated(new_player_health)
signal time_updated(tiempo_restante)

@export var player_life := 3
@export var tiempo_restante := 100
var has_won := false

func game_over():
	var scene_finish_instance = preload(SCENE_FINISH_FILE).instantiate()
	scene_finish_instance.set_title("DERROTA")

	# Repetir el nivel actual
	var current_level = get_tree().current_scene.scene_file_path
	scene_finish_instance.set_next_level(current_level)

	add_child(scene_finish_instance)


func game_victory():
	has_won = true
	var scene_finish_instance = preload(SCENE_FINISH_FILE).instantiate()
	scene_finish_instance.set_title("VICTORIA")

	# Elegir siguiente nivel según el actual
	var current_level = get_tree().current_scene.scene_file_path

	match current_level:
		"res://Niveles/nivel1.tscn":
			scene_finish_instance.set_next_level("res://Niveles/nivel2.tscn")

		"res://Niveles/nivel2.tscn":
			scene_finish_instance.set_next_level("res://Niveles/nivel3.tscn")

		"res://Niveles/nivel3.tscn":
			scene_finish_instance.set_next_level("res://Niveles/nivel1.tscn")

	add_child(scene_finish_instance)


func _on_personaje_player_hit() -> void:
	if has_won:
		return  # Ignorar el daño si ya ganó
	print("GameController detectó daño al jugador")
	player_life -= 1

	if player_life > 0:
		player_health_updated.emit(player_life)
	else:
		player_health_updated.emit(0)
		game_over()



func _on_area_2d_body_entered(body: Node2D) -> void:
	# Llegó a la bandera → victoria
	game_victory()


func _on_timer_timeout() -> void:
	if tiempo_restante > 0:
		tiempo_restante -= 1
	if tiempo_restante <= 0:
		game_over()

	time_updated.emit(tiempo_restante)
