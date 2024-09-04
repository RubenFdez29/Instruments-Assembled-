extends Control

#Función que se ejecuta al inicio cada vez que se ejecuta la interfaz 
# Menú Principal. Muestra los Instrumentos e inicializa la current_scene.
func _ready():
	global.current_scene = "world_mono"
	$Guitar.show()
	$Trumpet.show()
	$Tambourine.show()
	$Cello.show()	

#Posible funcion para mover con el mando en el menu
func _input(event):
	pass

#Función que permite mostrar y ocultar alternativamente los controles indicados.
func show_and_hide(first, second):
	first.show()
	second.hide()
	
#Funcionalidad del botón Jugar. Muestra el selector de personaje y oculta el
# Menú Principal.
func _on_start_pressed():
	show_and_hide($Character_selection, $Menu)
	$Sound_button.play()
	$Guitar.hide()
	$Trumpet.hide()
	$Tambourine.hide()
	$Cello.hide()
	$Principal.hide()
	$Character_selection/Selector.show()

#Funcionalidad del botón Load. Si existe archivo de guardado, lo carga e inicia
# el juego en el punto donde se ha generado el archivo.
func _on_load_pressed():
	if FileAccess.file_exists(SAVE.save_path):
		SAVE.load_game()
		SAVE.partida_cargada = true
		$Play_sound.play()
		global.character = SAVE.game_data["character"]
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		get_tree().change_scene_to_file("res://Scenes/Worlds/"+SAVE.game_data["Scene"]+".tscn")
	else:
		$Sound_button.play()

#Funcionalidad del botón Opciones.
func _on_options_pressed():
	show_and_hide($Options, $Menu)
	$Sound_button.play()

#Funcionalidad del botón Salir. Cierra el juego.
func _on_exit_pressed():
	get_tree().quit()

#Selector de personajes. (LÍNEAS 56-142)
#Sobre cada uno de los personajes disponibles se ha creado un botón invisible.
#Al seleccionar cualquiera de ellos, se cargan sus AnimatedSprite2D en el
# Jugador y se carga la escena inicial del juego con su Transición.
func _on_f_01_button_pressed():
	global.character = "F01"
	$Play_sound.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Worlds/world_mono.tscn")

func _on_f_05_button_pressed():
	global.character = "F05"
	$Play_sound.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Worlds/world_mono.tscn")

func _on_f_06_button_pressed():
	global.character = "F06"
	$Play_sound.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Worlds/world_mono.tscn")

func _on_f_07_button_pressed():
	global.character = "F07"
	$Play_sound.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Worlds/world_mono.tscn")
	
func _on_f_10_button_pressed():
	global.character = "F10"
	$Play_sound.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Worlds/world_mono.tscn")

func _on_f_12_button_pressed():
	global.character = "F12"
	$Play_sound.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Worlds/world_mono.tscn")

func _on_m_01_button_pressed():
	global.character = "M01"
	$Play_sound.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Worlds/world_mono.tscn")

func _on_m_03_button_pressed():
	global.character = "M03"
	$Play_sound.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Worlds/world_mono.tscn")

func _on_m_04_button_pressed():
	global.character = "M04"
	$Play_sound.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Worlds/world_mono.tscn")

func _on_m_05_button_pressed():
	global.character = "M05"
	$Play_sound.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Worlds/world_mono.tscn")

func _on_m_07_button_pressed():
	global.character = "M07"
	$Play_sound.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Worlds/world_mono.tscn")

func _on_m_12_button_pressed():
	global.character = "M12"
	$Play_sound.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Worlds/world_mono.tscn")

#Funcionalidad del botón Volver del selector de personajes.
#Oculta el selector de personaje y muestra el Menú Principal.
func _on_back_from_selection_pressed():
	show_and_hide($Menu, $Character_selection)
	$Sound_button.play()
	$Guitar.show()
	$Trumpet.show()
	$Tambourine.show()
	$Cello.show()
	$Principal.show()
	$Character_selection/Selector.hide()

#Funcionalidad del botón Vídeo del Menú Opciones.
func _on_video_pressed():
	show_and_hide($Video, $Options)
	$Sound_button.play()

#Funcionalidad del botón Audio del Menú Opciones.
func _on_audio_pressed():
	show_and_hide($Audio, $Options)
	$Sound_button.play()

#Funcionalidad del botón Volver del Menú Opciones.
func _on_back_from_options_pressed():
	show_and_hide($Menu, $Options)
	$Sound_button.play()

#Funcionalidad del check Pantalla completa del Menú de Vídeo.
func _on_fullscreen_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

#Funcionalidad del check Modo ventana sin bordes del Menú de Vídeo.
func _on_borderless_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

#Funcionalidad del check VSync del Menú de Vídeo.
func _on_v_sync_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

#Funcionalidad del botón Volver del Menú de Vídeo.
func _on_back_from_video_pressed():
	show_and_hide($Options, $Video)
	$Sound_button.play()

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

#Funcionalidad del botón Volver del Menú de Audio.
func _on_back_from_audio_pressed():
	show_and_hide($Options, $Audio)
	$Sound_button.play()

