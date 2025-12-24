class_name Personaje
extends CharacterBody2D

signal player_hit()


@export var SPEED = 350.0
@export var JUMP_Speed = 350.0
@export var gravity=100
@onready var sprite_2d_2: Sprite2D = $Sprite2D2
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animationPlayer= $AnimationPlayer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _physics_process(delta: float):
	
	var direction=Input.get_axis("izquierda","derecha")
	if direction:
		if direction<0:
		#539 es porque es la escala del personaje (la he determinado así para que sea más compacto)
		#direction devuelve -1 si se pulsa izquierda, y 1 si se pulsa derecha, pero eso me hace el personaje
		#más "gordo"
			direction=-0.539
		else:
			direction=0.539
	velocity.x=SPEED*direction
	
	if direction!=0:
		sprite_2d.scale.x=direction
		sprite_2d_2.scale.x=direction
	# Add the gravity.
	if not is_on_floor():
		velocity.y = velocity.y + gravity * delta
	
	var jump_pressed=Input.is_action_just_pressed("saltar")
	
	if jump_pressed and is_on_floor():
		velocity.y = velocity.y -  JUMP_Speed
		audio_stream_player_2d.playing= true

	# -----------------------------------------
	# ANIMACIONES
	# -----------------------------------------
	if not is_on_floor():
		animationPlayer.play("salto")


	else:
		if direction != 0:
			animationPlayer.play("andar")
		else:
			animationPlayer.play("idle")

	

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) :
	print("Un cuerpo ha entrado en el área: ",body.name)

func damage_received():
	print("daño recibido")
	player_hit.emit()
