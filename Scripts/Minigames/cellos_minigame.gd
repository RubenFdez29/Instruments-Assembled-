extends Node2D

var answer = ""
var solution = ""
var melody
var sonando = false
var contador = 0

#Función que se ejecuta al entrar en el minijuego del Cello desde su 
# casa mono. Reproduce el diálogo inicial.
func _ready():
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "cellos_minigame")
	await DialogueManager.dialogue_ended

#Función iterativa que llama a las funciones que habilitan las diferentes
# mecánicas de la escena.
func _process(delta):
	set_melody()

#Función que regula el valor de melody para poder avanzar entre los distintos
# audios del minijuego.
func set_melody():
	match contador:
		0:
			melody = $Bird_sound
			solution = "Bird"
		1:
			melody = $Horse_sound
			solution = "Horse"
		2:
			melody = $Elephant_sound
			solution = "Elephant"
		3:
			melody = $Dolphin_sound
			solution = "Dolphin"
		4:
			global.transition_scene = true
			change_scene()

#Función que comprueba si la respuesta dada coincide con la correcta y activa
# los cuadros de diálogo correspondientes.
func check_answer():
	if answer == solution:
		contador += 1
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "correct_answer")
	else:
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "wrong_answer")

#Al pulsar en cada uno de los cuatro animales, comprueba si se ha acertado
# llamando a la función check_answer. (LINEAS 49-65)
func _on_elephant_button_pressed():
	answer = "Elephant"
	check_answer()

func _on_dolphin_button_pressed():
	answer = "Dolphin"
	check_answer()

func _on_horse_button_pressed():
	answer = "Horse"
	check_answer()

func _on_bird_button_pressed():
	answer = "Bird"
	check_answer()

#Reproduce el audio correspondiente según el valor de melody. Contiene un
# timeout para evitar que las diferentes melodías se superpongan.
func _on_play_button_pressed():
	if !sonando:
		melody.play()
		sonando = true
		await get_tree().create_timer(melody.stream.get_length()).timeout
		sonando = false

#Gestiona el cambio de escenas a través de la comprobación de una 
# serie de condiciones cuando se han acertado todas las respuestas.
func change_scene():
	if global.transition_scene == true:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		global.dialogue_id = "cellos_world"
		if global.current_scene == "cellos_minigame" and contador == 4:
			get_tree().change_scene_to_file("res://Scenes/Worlds/cellos_world.tscn")
			global.finish_changescenes("cello_world")

