class_name Boss
extends Node2D

@onready var animation_player= $AnimationPlayer
const ESCENA_BARRIL = preload("res://enemigos/barril.tscn")








func launch_barrel():
	var instancia_barril=ESCENA_BARRIL.instantiate()
	instancia_barril.global_position = $CharacterSquareRed/CharacterHandRed.global_position
	get_tree().current_scene.add_child(instancia_barril)
	animation_player.play("reposo")
	


func _on_timer_timeout() -> void:
	animation_player.play("lanzar")
	$Timer.wait_time=randf_range(2,5)
