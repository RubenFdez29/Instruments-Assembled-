extends Node2D

var scene_world_red_bol = false
var scene_cello_bol = false

#Función que se ejecuta al entrar en la casa del Cello desde el pueblo rojo.
func _ready():
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "cellos_house_mono")
	$Player/AnimatedSprite2D.play(global.character + "_back_idle")
	return

#Función iterativa que llama a las funciones que habilitan las diferentes
# mecánicas de la escena.
func _process(delta):
	change_scenes()

#Activa la transición y el sonido de puerta al entrar en contacto con 
# la colisión de la puerta.
func _on_world_red_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		scene_world_red_bol = true
		TransitionScreen.door()

#Activa la transición al minijuego al entrar en contacto con 
# la colisión de la ventana.
func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		scene_cello_bol = true

#Gestiona el cambio de escenas a través de la comprobación de una 
# serie de condiciones para salir en el escenario correcto.
func change_scenes():
	if global.transition_scene == true:
		global.scene_cello = true
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		if global.current_scene == "cellos_house_mono" and scene_world_red_bol == true:
			get_tree().change_scene_to_file("res://Scenes/Worlds/world_red.tscn")
			global.finish_changescenes("world_red")
		elif global.current_scene == "cellos_house_mono" and scene_cello_bol == true:
			get_tree().change_scene_to_file("res://Scenes/Minigames/cellos_minigame.tscn")
			global.finish_changescenes("cello_minigame")

