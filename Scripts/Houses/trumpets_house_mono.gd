extends Node2D

var scene_world_green_bol = false
var scene_trumpet_bol = false

#Función que se ejecuta al entrar en la casa de la Trompeta desde el pueblo verde.
func _ready():
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "trumpets_house_mono")
	$Player/AnimatedSprite2D.play(global.character + "_back_idle")
	return

#Función iterativa que llama a las funciones que habilitan las diferentes
# mecánicas de la escena.
func _process(delta):
	change_scenes()

#Activa la transición y el sonido de puerta al entrar en contacto con 
# la colisión de la puerta.
func _on_world_green_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		scene_world_green_bol = true
		TransitionScreen.door()

#Activa la transición al minijuego al entrar en contacto con 
# la colisión de el ático.
func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		scene_trumpet_bol = true

#Gestiona el cambio de escenas a través de la comprobación de una 
# serie de condiciones para salir en el escenario correcto.
func change_scenes():
	if global.transition_scene == true:
		global.scene_trumpet = true
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		if global.current_scene == "trumpets_house_mono" and scene_world_green_bol == true:
			get_tree().change_scene_to_file("res://Scenes/Worlds/world_green.tscn")
			global.finish_changescenes("world_green")
		elif global.current_scene == "trumpets_house_mono" and scene_trumpet_bol == true:
			get_tree().change_scene_to_file("res://Scenes/Minigames/trumpets_minigame.tscn")
			global.finish_changescenes("trumpet_minigame")

