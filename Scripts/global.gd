extends Node

var character = ""
var current_scene = "world_mono"
var current_world = ""
var player_current_attack = false
var transition_scene = false
var game_first_loadin = true
var enemy_kill = 0

#Variables de posición inicial del Jugador en cada una de las escenas.
#(LINEAS 11-41)
var player_start_posx = 25
var player_start_posy = 350

var scene_school = false
var player_exit_schoolside_posx = 192
var player_exit_schoolside_posy = 304

var player_exit_guitarside_posx = 169
var player_exit_guitarside_posy = 524

var scene_cello = false
var player_exit_celloside_posx = 633
var player_exit_celloside_posy = 192

var scene_trumpet = false
var player_exit_trumpetside_posx = 1209
var player_exit_trumpetside_posy = 440

var scene_forest = false
var player_exit_forestside_posx = 1248
var player_exit_forestside_posy = 63

#var scene_percu = false
#var player_exit_percuside_posx = 1265
#var player_exit_percuside_posy = 63

#var scene_flute = false
#var player_exit_fluteside_posx = 48
#var player_exit_fluteside_posy = 568


#Variables para los diálogos.
var first_time = true
var dialogue_running = false
var dialogue_id = ""


#Función que asigna la variable global Current_scene.
func finish_changescenes(scene):
	if transition_scene == true:
		transition_scene = false
		
		if scene == "world_mono":
			current_scene = "world_mono"
		elif scene == "school":
			current_scene = "school"
		elif scene == "guitar_mono":
			current_scene = "guitars_house_mono"
		elif scene == "guitar_minigame":
			current_scene = "guitars_minigame"
		elif scene == "guitar_world":
			current_scene = "guitars_world"
		elif scene == "guitar_house":
			current_scene = "guitars_house"
		elif scene == "world_red":
			current_scene = "world_red"
		elif scene == "cello_mono":
			current_scene = "cellos_house_mono"
		elif scene == "cello_minigame":
			current_scene = "cellos_minigame"
		elif scene == "cello_house":
			current_scene = "cellos_house"
		elif scene == "cello_world":
			current_scene = "cellos_world"
		elif scene == "world_green":
			current_scene = "world_green"
		elif scene == "trumpet_mono":
			current_scene = "trumpets_house_mono"
		elif scene == "trumpet_minigame":
			current_scene = "trumpets_minigame"
		elif scene == "trumpet_world":
			current_scene = "trumpets_world"
		elif scene == "trumpet_house":
			current_scene = "trumpets_house"
		elif scene == "world_yellow":
			current_scene = "world_yellow"
		elif scene == "forest" or scene == "world":
			current_scene = "world"
		elif scene == "end":
			current_scene = "end"

