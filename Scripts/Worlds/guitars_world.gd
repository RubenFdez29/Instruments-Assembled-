extends Node2D

var initial_position_x = 56
var initial_position_y = 238

#Función que se ejecuta al entrar en el mundo de la Guitarra desde el minijuego.
# Reproduce su música en bucle.
func _ready():
	$Guitars_nightmare.play()
	
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "guitars_world")
	$Player/AnimatedSprite2D.play(global.character + "_front_idle")
	return

#Función iterativa que llama a las funciones que habilitan las diferentes
# mecánicas de la escena.
func _process(delta):
	change_scenes()
	
	if Input.is_action_just_pressed("Pause"):
		$Guitars_nightmare.get_stream_paused()

#Función que carga el respawn inicial del personaje al caer al abismo.
func _on_abbys_respawn_point_body_entered(body):
	if body.has_method("player"):
		$Player.position.x = initial_position_x
		$Player.position.y = initial_position_y

#Activa la transición a la casa de la Guitarra al entrar en contacto con 
# la colisión del portal.
func _on_guitars_house_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		global.first_time = true

#Gestiona el cambio de escenas a través de la comprobación de una 
# serie de condiciones para salir en el escenario correcto.
func change_scenes():
	if global.transition_scene == true:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		if global.current_scene == "guitars_world":
			get_tree().change_scene_to_file("res://Scenes/Houses/guitars_house.tscn")
			global.finish_changescenes("guitar_house")

