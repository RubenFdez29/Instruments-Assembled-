extends Node2D

var answer = ""
var solution = ""
var melody
var sonando = false
var contador = 0

#Función que se ejecuta al entrar en el minijuego de la Guitarra desde su 
# casa mono. Reproduce el diálogo inicial.
func _ready():
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "guitars_minigame")


#Función iterativa que llama a las funciones que habilitan las diferentes
# mecánicas de la escena.
func _process(delta):
	set_melody()
	
#Función que regula el valor de melody para poder avanzar entre los distintos
# audios del minijuego.
func set_melody():
	
	match contador:
		0:
			melody = $"1st_melody"
			solution = "Stay"
		1:
			melody = $"2nd_melody"
			solution = "Up"
		2:
			melody = $"3rd_melody"
			solution = "Down"
		3:
			melody = $"4th_melody"
			solution = "Up"
		4:
			melody = $"5th_melody"
			solution = "Down"
		5:
			melody = $"6th_melody"
			solution = "Stay"
		6:
			melody = $"7th_melody"
			solution = "Down"
		7:
			melody = $"8th_melody"
			solution = "Up"
		8:
			global.transition_scene = true
			change_scene()
			pass

#Función que comprueba si la respuesta dada coincide con la correcta y activa
# los cuadros de diálogo correspondientes.
func check_answer():
	if solution == answer:
		contador += 1
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "correct_answer")
		return
	else:
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "wrong_answer")

#Al pulsar cada uno de los tres botones de respuesta, comprueba si se ha 
# acertado llamando a la función check_answer. (LINEAS 65-80)
func _on_up_button_pressed():
	answer = "Up"
	check_answer()

func _on_down_button_pressed():
	answer = "Down"
	check_answer()

func _on_stay_button_pressed():
	answer = "Stay"
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
		if global.current_scene == "guitars_minigame" and contador == 8:
			get_tree().change_scene_to_file("res://Scenes/Worlds/guitars_world.tscn")
			global.finish_changescenes("guitar_world")

