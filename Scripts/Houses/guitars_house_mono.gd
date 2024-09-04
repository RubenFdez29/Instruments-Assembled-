extends Node2D

var scene_world_mono_bol = false
var scene_guitar_bol = false

#Función que se ejecuta al entrar en la casa de la Guitarra desde el pueblo
# monocromático. La Guitarra no se mueve.
func _ready():
	$Guitar/AnimatedSprite2D.play("static")
	
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "guitars_mono")
	$Player/AnimatedSprite2D.play(global.character + "_back_idle")
	return

#Función iterativa que llama a las funciones que habilitan las diferentes
# mecánicas de la escena.
func _process(delta):
	change_scenes()

#Activa la transición y el sonido de puerta al entrar en contacto con 
# la colisión de la puerta.
func _on_world_mono_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		scene_world_mono_bol = true
		TransitionScreen.door()

#Activa la transición al minijuego al entrar en contacto con 
# la colisión de la cama.
func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		scene_guitar_bol = true

#Gestiona el cambio de escenas a través de la comprobación de una 
# serie de condiciones para salir en el escenario correcto.
func change_scenes():
	if global.transition_scene == true:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		if global.current_scene == "guitars_house_mono" and scene_world_mono_bol == true:
			get_tree().change_scene_to_file("res://Scenes/Worlds/world_mono.tscn")
			global.finish_changescenes("world_mono")
		elif global.current_scene == "guitars_house_mono" and scene_guitar_bol == true:
			get_tree().change_scene_to_file("res://Scenes/Minigames/guitars_minigame.tscn")
			global.finish_changescenes("guitar_minigame")

