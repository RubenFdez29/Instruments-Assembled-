extends Node2D

#Función que se ejecuta al entrar en la casa de la Trompeta desde su mundo.
# Reproduce su música en bucle.
func _ready():
	$Trumpets_travel.play()
	
	if global.first_time == true:
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "trumpets_house")
		$Player/AnimatedSprite2D.play(global.character + "_back_idle")
		global.first_time = false
		return
	
#Función iterativa que llama a las funciones que habilitan las diferentes
# mecánicas de la escena.
func _process(delta):
	change_scenes()
	
	if Input.is_action_just_pressed("Pause"):
		$Trumpets_travel.get_stream_paused()

#Activa la transición y el sonido de puerta al entrar en contacto con 
# la colisión de la puerta.
func _on_world_yellow_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		TransitionScreen.door()

#Gestiona el cambio de escenas a través de la comprobación de una 
# serie de condiciones para salir en el escenario correcto.
func change_scenes():
	if global.transition_scene == true:
		global.scene_trumpet = true
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		if global.current_scene == "trumpets_house" and global.current_world == "color":
			get_tree().change_scene_to_file("res://Scenes/Worlds/world.tscn")
			global.finish_changescenes("world")
		elif global.current_scene == "trumpets_house":
			get_tree().change_scene_to_file("res://Scenes/Worlds/world_yellow.tscn")
			global.finish_changescenes("world_yellow")

