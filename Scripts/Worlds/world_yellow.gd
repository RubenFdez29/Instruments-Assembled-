extends Node2D

var scene_school_bol = false
var scene_guitar_bol = false
var scene_cello_bol = false
var scene_trumpet_bol = false
var scene_forest_bol = false

#Función que se ejecuta cada vez que se carga la escena Pueblo amarillo.
# Carga el Jugador en sus coordenadas correspondientes y reproduce la música
# en bucle.
func _ready():
	$Travelers_home_trio.play()
	global.current_world = "yellow"

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
	else:
		$Player.position.x = global.player_exit_guitarside_posx
		$Player.position.y = global.player_exit_guitarside_posy

#Función iterativa que llama a las funciones que habilitan las diferentes
# mecánicas de la escena.
func _process(delta):
	change_scene()
	
	if Input.is_action_just_pressed("Pause"):
		$Travelers_home_trio.get_stream_paused()

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

#Activa la transición al Bosque/Pueblo color al entrar en contacto con 
# la colisión del Bosque.
func _on_forest_mono_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		scene_forest_bol = true

#Gestiona el cambio de escenas a través de la comprobación de una 
# serie de condiciones para salir en el escenario correcto
func change_scene():
	if global.transition_scene == true:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		if global.current_scene == "world_yellow" and scene_school_bol == true:
			get_tree().change_scene_to_file("res://Scenes/Houses/school.tscn")
			global.finish_changescenes("school")
		elif global.current_scene == "world_yellow" and scene_guitar_bol == true:
			get_tree().change_scene_to_file("res://Scenes/Houses/guitars_house.tscn")
			global.finish_changescenes("guitar_house")
		elif global.current_scene == "world_yellow" and scene_cello_bol == true:
			get_tree().change_scene_to_file("res://Scenes/Houses/cellos_house.tscn")
			global.finish_changescenes("cello_house")
		elif global.current_scene == "world_yellow" and scene_trumpet_bol == true:
			get_tree().change_scene_to_file("res://Scenes/Houses/trumpets_house.tscn")
			global.finish_changescenes("trumpet_house")
		elif global.current_scene == "world_yellow" and scene_forest_bol == true:
			global.scene_forest = true
			get_tree().change_scene_to_file("res://Scenes/Worlds/world.tscn")
			global.finish_changescenes("forest")

