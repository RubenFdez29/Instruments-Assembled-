extends Node2D

var Enemy = preload("res://Scenes/Characters/enemy.tscn")
var contador = 0

#Función que se ejecuta al entrar en el mundo del Cello desde el minijuego.
# Reproduce su música y diálogos.
func _ready():
	$Spawn.hide()
	$Cellos_introduction.play()
	global.first_time = true

	DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), global.dialogue_id)
	$Player/AnimatedSprite2D.play(global.character + "_side_idle")
	await get_tree().create_timer($Cellos_introduction.stream.get_length()).timeout
	
	global.dialogue_id = ""
	$Slimes_attack.play()
	$Spawn.show()
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "cellos_explain")

#Función iterativa que llama a las funciones que habilitan las diferentes
# mecánicas de la escena.
func _process(delta):
	if global.first_time == true:
		cellos_apologize()
	
	if Input.is_action_just_pressed("Pause"):
		$Slimes_attack.get_stream_paused()

#Cada vez que el timeout llega a 0, genera un hijo de la instanciación de la
# escena del Enemigo, hasta un máximo de 4.
func _on_spawn_timer_timeout():
	var enemy = Enemy.instantiate()

	if !global.dialogue_running and contador < 4:
		add_child(enemy)
		enemy.position = $Spawn.position
		contador += 1
	else:
		pass

#Una vez se han eliminado a los 4 enemigos, se activan las funcionalidades
# para el último diálogo de la escena, y al terminar, se activa el cambio
# de escena.
func cellos_apologize():
	if global.enemy_kill == 4:
		global.enemy_kill += 1
		$Spawn.hide()
		$Slimes_attack.stop()

		global.dialogue_id = "cellos_apologize"
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), global.dialogue_id)
		$Player/AnimatedSprite2D.play(global.character + "_side_idle")
		$Cellos_apologize.play()
		await get_tree().create_timer($Cellos_apologize.stream.get_length()).timeout
		
		global.dialogue_id = ""
		global.transition_scene = true

		change_scenes()

#Gestiona el cambio de escenas a través de la comprobación de una 
# serie de condiciones para salir en el escenario correcto.
func change_scenes():
	if global.transition_scene == true:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		if global.current_scene == "cellos_world":
			get_tree().change_scene_to_file("res://Scenes/Houses/cellos_house.tscn")
			global.finish_changescenes("cello_house")

