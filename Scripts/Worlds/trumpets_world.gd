extends Node2D

#Función que se ejecuta al entrar en el mundo de la Trompeta desde el minijuego.
# Reproduce su música en bucle.
func _ready():
	$Meeting_Cantina.play()
	global.first_time = true
	
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "trumpets_world_start")
	$Player/AnimatedSprite2D.play(global.character + "_front_idle")
	await DialogueManager.dialogue_ended

#Función iterativa que llama a las funciones que habilitan las diferentes
# mecánicas de la escena.
func _process(delta):
	change_scenes()
	
	if Input.is_action_just_pressed("Pause"):
		$Meeting_Cantina.get_stream_paused()

#Activa la transición a la casa de la Trompeta al entrar en contacto con 
# la colisión de las escaleras.
func _on_trumpets_house_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		global.first_time = true

#Gestiona el cambio de escenas a través de la comprobación de una 
# serie de condiciones para salir en el escenario correcto.
func change_scenes():
	if global.transition_scene == true:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		if global.current_scene == "trumpets_world":
			get_tree().change_scene_to_file("res://Scenes/Houses/trumpets_house.tscn")
			global.finish_changescenes("trumpet_house")

