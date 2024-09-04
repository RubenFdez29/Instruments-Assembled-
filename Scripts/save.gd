extends Node

#Archivo de guardado. Se puede localizar siguiendo:
#Projects -> Open User Data Folder.
var save_path = "user://save_game.dat"

#Diccionario que almacena las tres variables principales para el guardado
# de partida.
var game_data = {
	"Character" : global.character,
	"Sceen" : global.current_scene,
	"World" : global.current_world
}

var partida_cargada = false

#Función que genera y guarda los datos de la partida en un archivo cifrado .dat
func save_game():
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	
	save_file.store_var(game_data) #Guardamos la variable
	save_file = null #Para cerrar el archivo

#Función que, si existe archivo de guardado, lo carga y restaura el juego
# en el punto donde se creó ese archivo de guardado.
func load_game():
	if FileAccess.file_exists(save_path):
		var save_file = FileAccess.open(save_path, FileAccess.READ)
	
		game_data = save_file.get_var() #Cargamos la variable.
		save_file = null #Para cerrar el archivo

