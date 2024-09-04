extends Node2D

var melody
var sonando = false
var contador = 0

#Función que se ejecuta al entrar en el minijuego de la Trompeta desde su 
# casa mono. Reproduce el diálogo inicial.
func _ready():
	$Open_door.hide()
	
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "trumpets_minigame")
	await DialogueManager.dialogue_ended

#Función iterativa que llama a las funciones que habilitan las diferentes
# mecánicas de la escena.
func _process(delta):
	# Cuando todos los botones están ocultos, se muestra el botón Puerta.
	if contador == 5:
		$Open_door.show()
	else:
		pass

#Función que reproduce el audio correspondiente según el valor de melody.
#Contiene un timeout para evitar que las diferentes melodías se superpongan.
func play():
	if !sonando:
		melody.play()
		sonando = true
		await get_tree().create_timer(melody.stream.get_length()).timeout
		melody = null
		sonando = false

#Al pulsar cada botón de audio, se asigna el audio correspondiente a melody 
# y se llama a play. (LINEAS 34-74)
func _on_clarinet_1_pressed():
	melody = $Clarinet_1
	play()

func _on_clarinet_2_pressed():
	melody = $Clarinet_2
	play()

func _on_violin_1_pressed():
	melody = $Violin_1
	play()

func _on_violin_2_pressed():
	melody = $Violin_2
	play()

func _on_piano_1_pressed():
	melody = $Piano_1
	play()

func _on_piano_2_pressed():
	melody = $Piano_2
	play()

func _on_tuba_1_pressed():
	melody = $Tuba_1
	play()

func _on_tuba_2_pressed():
	melody = $Tuba_2
	play()

func _on_xilo_1_pressed():
	melody = $Xilo_1
	play()

func _on_xilo_2_pressed():
	melody = $Xilo_2
	play()

#Casillas de verificación de la primera columna. Al pertenecer al mismo grupo
# de botones llamado "Group_1", solo puede haber activo uno a la vez.
func _on_check_clarinet_1_toggled(toggled_on):
	pass

func _on_check_violin_1_toggled(toggled_on):
	pass

func _on_check_piano_1_toggled(toggled_on):
	pass

func _on_check_tuba_1_toggled(toggled_on):
	pass

func _on_check_xilo_1_toggled(toggled_on):
	pass

#Casillas de verificación de la segunda columna. Al pertenecer al mismo grupo
# de botones llamado "Group_2", solo puede haber activo uno a la vez.
func _on_check_clarinet_2_toggled(toggled_on):
	pass

func _on_check_violin_2_toggled(toggled_on):
	pass

func _on_check_piano_2_toggled(toggled_on):
	pass

func _on_check_tuba_2_toggled(toggled_on):
	pass

func _on_check_xilo_2_toggled(toggled_on):
	pass

#Al pulsar cada botón de intrumento, comprueba si están activas las casiilas 
# de verificación correctas. Si lo están, se esconden el botón y los chechboxes
# correctos. (LINEAS 110-171)
func _on_clarinet_button_pressed():
	if $Audios/Check_clarinet_1.button_pressed and $Audios/Check_clarinet_2.button_pressed:
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "correct_answer")
		$Instruments/Clarinet_button.hide()
		$Audios/Clarinet_1.hide()
		$Audios/Check_clarinet_1.hide()
		$Audios/Clarinet_2.hide()
		$Audios/Check_clarinet_2.hide()
		contador += 1
	else:
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "wrong_answer")

func _on_tuba_button_pressed():
	if $Audios/Check_tuba_1.button_pressed and $Audios/Check_tuba_2.button_pressed:
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "correct_answer")
		$Instruments/Tuba_button.hide()
		$Audios/Tuba_1.hide()
		$Audios/Check_tuba_1.hide()
		$Audios/Tuba_2.hide()
		$Audios/Check_tuba_2.hide()
		contador += 1
	else:
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "wrong_answer")

func _on_piano_button_pressed():
	if $Audios/Check_piano_1.button_pressed and $Audios/Check_piano_2.button_pressed:
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "correct_answer")
		$Instruments/Piano_button.hide()
		$Audios/Piano_1.hide()
		$Audios/Check_piano_1.hide()
		$Audios/Piano_2.hide()
		$Audios/Check_piano_2.hide()
		contador += 1
	else:
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "wrong_answer")

func _on_xilo_button_pressed():
	if $Audios/Check_xilo_1.button_pressed and $Audios/Check_xilo_2.button_pressed:
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "correct_answer")
		$Instruments/Xilo_button.hide()
		$Audios/Xilo_1.hide()
		$Audios/Check_xilo_1.hide()
		$Audios/Xilo_2.hide()
		$Audios/Check_xilo_2.hide()
		contador += 1
	else:
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "wrong_answer")

func _on_violin_button_pressed():
	if $Audios/Check_violin_1.button_pressed and $Audios/Check_violin_2.button_pressed:
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "correct_answer")
		$Instruments/Violin_button.hide()
		$Audios/Violin_1.hide()
		$Audios/Check_violin_1.hide()
		$Audios/Violin_2.hide()
		$Audios/Check_violin_2.hide()
		contador += 1
	else:
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "wrong_answer")

#Botón que se muestra al haber acertado todas las pruebas y que activa el 
# cambio de escena.
func _on_open_door_pressed():
	global.transition_scene = true
	TransitionScreen.door()
	change_scene()

#Gestiona el cambio de escenas a través de la comprobación de una 
# serie de condiciones cuando se han acertado todas las respuestas.
func change_scene():
	if global.transition_scene == true:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		if global.current_scene == "trumpets_minigame":
			get_tree().change_scene_to_file("res://Scenes/Worlds/trumpets_world.tscn")
			global.finish_changescenes("trumpet_world")

