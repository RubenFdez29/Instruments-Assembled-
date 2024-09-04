extends Node2D

#Función que se ejecuta al inicio cada vez que se carga la escena 
# Escuela. Repoduce la música de fondo en bucle.
func _ready():
	$Bossa_school.play()
	
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "school_start")
	$Player/AnimatedSprite2D.play(global.character + "_back_idle")
	return

#Función iterativa que llama a las funciones que habilitan las diferentes
# mecánicas de la escena.
func _process(delta):
	change_scenes()
	
	if Input.is_action_just_pressed("Pause"):
		$Bossa_school.get_stream_paused()

#Activa la transición y el sonido de puerta al entrar en contacto con 
# la colisión de la puerta.
func _on_world_full_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		TransitionScreen.door()

#Cuando el Jugador entra en el área de cada libro, se asigna a la variable
# dialogue_id el código de inicio de la sección de texto que se quiere reproducir.
func _on_book_0_area_body_entered(body):
	if body.has_method("player"):
		global.dialogue_id = "book0_start"

func _on_book_1_area_body_entered(body):
	if body.has_method("player"):
		global.dialogue_id = "book1_start"

func _on_book_2_area_body_entered(body):
	if body.has_method("player"):
		global.dialogue_id = "book2_start"

func _on_book_3_area_body_entered(body):
	if body.has_method("player"):
		global.dialogue_id = "book3_start"

#Cuando el Jugador sale del área de cada libro, se asigna a la variable
# dialogue_id el valor "" para evitar que se siga reproduciendo el diálogo.
func _on_book_0_area_body_exited(body):
	if body.has_method("player"):
		global.dialogue_id = ""

func _on_book_1_area_body_exited(body):
	if body.has_method("player"):
		global.dialogue_id = ""

func _on_book_2_area_body_exited(body):
	if body.has_method("player"):
		global.dialogue_id = ""

func _on_book_3_area_body_exited(body):
	if body.has_method("player"):
		global.dialogue_id = ""

#Gestiona el cambio de escenas a través de la comprobación de una 
# serie de condiciones para salir en el escenario de pueblo correcto.
func change_scenes():
	if global.transition_scene == true:
		global.scene_school = true
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		if global.current_scene == "school" and global.current_world == "red":
			get_tree().change_scene_to_file("res://Scenes/Worlds/world_red.tscn")
			global.finish_changescenes("world_red")
		elif global.current_scene == "school" and global.current_world == "green":
			get_tree().change_scene_to_file("res://Scenes/Worlds/world_green.tscn")
			global.finish_changescenes("world_green")
		elif global.current_scene == "school" and global.current_world == "yellow":
			get_tree().change_scene_to_file("res://Scenes/Worlds/world_yellow.tscn")
			global.finish_changescenes("world_yellow")
		elif global.current_scene == "school" and global.current_world == "color":
			get_tree().change_scene_to_file("res://Scenes/Worlds/world.tscn")
			global.finish_changescenes("world")
		elif global.current_scene == "school":
			get_tree().change_scene_to_file("res://Scenes/Worlds/world_mono.tscn")
			global.finish_changescenes("world_mono")

