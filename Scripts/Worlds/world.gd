extends Node2D

var scene_school_bol = false
var scene_guitar_bol = false
var scene_cello_bol = false
var scene_trumpet_bol = false
var scene_forest_bol = false
var scene_end_bol = false

#Función que se ejecuta cada vez que se carga la escena Pueblo color.
# Carga el Jugador en sus coordenadas correspondientes y reproduce la música
# en bucle.
func _ready():
	$Travelers_home_tutti.play()
	global.current_world = "color"
	
	if global.game_first_loadin == true:
		$Player.position.x = global.player_start_posx
		$Player.position.y = global.player_start_posy
	elif global.game_first_loadin == false and global.scene_school == true:
		$Player.position.x = global.player_exit_schoolside_posx
		$Player.position.y = global.player_exit_schoolside_posy
		global.scene_school = false
	elif global.game_first_loadin == false and global.scene_cello == true:
		$Player.position.x = global.player_exit_celloside_posx
		$Player.position.y = global.player_exit_celloside_posy
		global.scene_cello = false
	elif global.game_first_loadin == false and global.scene_trumpet == true:
		$Player.position.x = global.player_exit_trumpetside_posx
		$Player.position.y = global.player_exit_trumpetside_posy
		global.scene_trumpet = false
	elif global.game_first_loadin == false and global.scene_forest == true:
		$Player.position.x = global.player_exit_forestside_posx
		$Player.position.y = global.player_exit_forestside_posy
		global.scene_forest = false
		$Player/AnimatedSprite2D.play(global.character + "_front_idle")
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "world_color")
	else:
		$Player.position.x = global.player_exit_guitarside_posx
		$Player.position.y = global.player_exit_guitarside_posy

#Función iterativa que llama a las funciones que habilitan las diferentes
# mecánicas de la escena.
func _process(delta):
	change_scene()
	
	if Input.is_action_just_pressed("Pause"):
		$Travelers_home_tutti.get_stream_paused()

#Activa la transición a la escuela y el sonido de puerta al 
# entrar en contacto con la colisión de la puerta.
func _on_school_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		scene_school_bol = true
		TransitionScreen.door()

#Activa la transición a la casa de la Guitarra y el sonido de 
# puerta al entrar en contacto con la colisión de la puerta.
func _on_guitars_house_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		scene_guitar_bol = true
		TransitionScreen.door()

#Activa la transición a la casa del Cello y el sonido de 
# puerta al entrar en contacto con la colisión de la puerta.
func _on_cellos_house_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		scene_cello_bol = true
		TransitionScreen.door()

#Activa la transición a la casa de la Trompeta y el sonido de 
# puerta al entrar en contacto con la colisión de la puerta.
func _on_trumpets_house_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		scene_trumpet_bol = true
		TransitionScreen.door()

#Activará la transición al Bosque al entrar en contacto con 
# la colisión del Bosque.
func _on_forest_mono_transition_point_body_entered(body):
	pass

#Activará la transición al Lago al entrar en contacto con 
# la colisión del Lago.
func _on_lake_mono_transition_point_body_entered(body):
	pass # Replace with function body.

#Activa la transición a la escena de cierre del juego, al entrar en contacto
#con la colisión de salida del pueblo.
func _on_end_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		scene_end_bol = true

#Gestiona el cambio de escenas a través de la comprobación de una 
# serie de condiciones para salir en el escenario correcto
func change_scene():
	if global.transition_scene == true:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		if global.current_scene == "world" and scene_school_bol == true:
			get_tree().change_scene_to_file("res://Scenes/Houses/school.tscn")
			global.finish_changescenes("school")
		elif global.current_scene == "world" and scene_guitar_bol == true:
			get_tree().change_scene_to_file("res://Scenes/Houses/guitars_house.tscn")
			global.finish_changescenes("guitar_house")
		elif global.current_scene == "world" and scene_cello_bol == true:
			get_tree().change_scene_to_file("res://Scenes/Houses/cellos_house.tscn")
			global.finish_changescenes("cello_house")
		elif global.current_scene == "world" and scene_trumpet_bol == true:
			get_tree().change_scene_to_file("res://Scenes/Houses/trumpets_house.tscn")
			global.finish_changescenes("trumpet_house")
		elif global.current_scene == "world" and scene_end_bol == true:
			get_tree().change_scene_to_file("res://Scenes/end.tscn")
			global.finish_changescenes("end")

