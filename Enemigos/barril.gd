class_name Barril
extends RigidBody2D

const BARRIL_ROJO = preload("res://assets/PNG/barril_rojo.png")

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@export var demasiasdo_abajo=1000
var damage_done = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) :
	if position.y>demasiasdo_abajo:
		queue_free()


func _on_body_entered(body) :
	if body is Personaje:
		if not damage_done:
			print("Jugador herido")
			damage_done=true
			$Barril.texture=BARRIL_ROJO
			audio_stream_player.playing= true
			if body.has_method("damage_received"):
				body.damage_received()
