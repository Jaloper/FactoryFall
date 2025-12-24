extends CanvasLayer

@onready var button: Button = $VBoxContainer/Button

var next_level_path: String = ""   # Nivel a cargar al pulsar el botón

func set_title(title: String):
	$VBoxContainer/Label.text = title

func set_next_level(path: String):
	next_level_path = path

func _on_button_button_down() -> void:
	if next_level_path != "":
		get_tree().change_scene_to_file(next_level_path)
	else:
		push_warning("Error: no se cargó correctamente la ruta del nivel")
