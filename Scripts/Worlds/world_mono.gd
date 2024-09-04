extends Node2D

var scene_school_bol = false
var scene_guitar_bol = false

#Función que se ejecuta cada vez que se carga la escena Pueblo monocromático.
# Carga el Jugador en sus coordenadas correspondientes.
func _ready():
	if global.game_first_loadin == true:
		$Player.position.x = global.player_start_posx
		$Player.position.y = global.player_start_posy
		$Player/AnimatedSprite2D.play(global.character + "_front_idle")
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "tutorial")
	elif global.game_first_loadin == false and global.scene_school == true:
		$Player.position.x = global.player_exit_schoolside_posx
		$Player.position.y = global.player_exit_schoolside_posy
		global.scene_school = false
	else:
		$Player.position.x = global.player_exit_guitarside_posx
		$Player.position.y = global.player_exit_guitarside_posy

#Función iterativa que llama a las funciones que habilitan las diferentes
# mecánicas de la escena.
func _process(delta):
	change_scene()

#En contacto con el área definida, muestra el diálogo en pantalla.
func _on_start_dialogue_body_entered(body):
	if global.first_time == true:
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "inicial_start")
		global.first_time = false
		$Player/AnimatedSprite2D.play(global.character + "_front_idle")
		return

#Activa la transición a la escuela y el sonido de puerta al 
# entrar en contacto con la colisión de la puerta.
func _on_school_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		scene_school_bol = true
		TransitionScreen.door()

#Activa la transición a la casa de la Guitarra monocromática y el sonido de 
# puerta al entrar en contacto con la colisión de la puerta.
func _on_guitars_house_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		scene_guitar_bol = true
		TransitionScreen.door()

#Gestiona el cambio de escenas a través de la comprobación de una 
# serie de condiciones para salir en el escenario correcto.
func change_scene():
	if global.transition_scene == true:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		if global.current_scene == "world_mono" and scene_school_bol == true:
			get_tree().change_scene_to_file("res://Scenes/Houses/school.tscn")
			global.game_first_loadin = false
			global.finish_changescenes("school")
		elif global.current_scene == "world_mono" and scene_guitar_bol == true:
			get_tree().change_scene_to_file("res://Scenes/Houses/guitars_house_mono.tscn")
			global.game_first_loadin = false
			global.finish_changescenes("guitar_mono")

