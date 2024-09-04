extends Control

var options = false

#Función que se ejecuta cada vez que se carga la Interfaz Menú de pausa.
func _ready():
	visible = false

#Función que gestiona la respuesta al input predefinido.
func _input(event):
	if global.dialogue_id != "cellos_world" and global.dialogue_id != "cellos_apologize":
		if event.is_action_pressed("Pause") and !options:
			visible = not get_tree().paused
			get_tree().paused = not get_tree().paused

#Función que gestiona el botón para volver al Menú principal, activando
# la Transición.
func _on_main_menu_pressed():
	$Menu_sound.play()
	visible = not get_tree().paused
	get_tree().paused = not get_tree().paused
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

#Botón que llama a la función que genera y guarda los datos de la partida.
func _on_save_game_pressed():
	SAVE.game_data["character"] = global.character
	SAVE.game_data["Scene"] = global.current_scene
	SAVE.game_data["World"] = global.current_world
	SAVE.save_game()

#Funcionalidad del botón Opciones del Menú de Pausa.
func _on_options_pressed():
	options = true
	$Main_menu.hide()
	$Save_game.hide()
	$Options.hide()
	$RichTextLabel.hide()
	$Audio.show()

#Funcionalidad del botón Volver del Menú de Opciones.
func _on_back_from_audio_pressed():
	options = false
	$Main_menu.show()
	$Save_game.show()
	$Options.show()
	$RichTextLabel.show()
	$Audio.hide()
	
#Función que regula el volumen.
func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value)

#Funcionalidad del slider Master del Menú de Audio.
func _on_master_value_changed(value):
	volume(0, value)

#Funcionalidad del slider Música del Menú de Audio.
func _on_music_value_changed(value):
	volume(1, value)

#Funcionalidad del slider Efectos de sonido del Menú de Audio.
func _on_sound_fx_value_changed(value):
	volume(2, value)

