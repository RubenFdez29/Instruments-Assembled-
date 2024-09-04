extends CharacterBody2D

const speed = 100
#const maxspeed = 200
const gravity = 9
var jump = 200

var current_dir = "down"
var animated_sprite
var anim = ""
var animation_prefix = global.character + "_"

var enemy_inattack_range = false
var attack_ip = false

#Función que se ejecuta al inicio cada vez que se instancia la escena 
# del Jugador. Repoduce su cuadro de animaciones.
func _ready():
	animated_sprite = $AnimatedSprite2D
	animated_sprite.play()
	Input.is_action_just_pressed("ui")
#Función iterativa que llama a las funciones que habilitan las diferentes
# mecánicas relacionadas con el mundo, el Enemigo, las físicas, etc.
func _physics_process(delta):
	player_movement(delta)
	attack()
	current_camera()
	dialogue()
	if SAVE.partida_cargada == true:
		cargar_partida()
		SAVE.partida_cargada = false

#Función que lo denomina como Jugador
func player():
	pass

#Función que, si se ha cargado la partida, restaura los valores de current_scene
# y current_world al valor de cuando se generó el archivo de guardado.
func cargar_partida():
	if SAVE.partida_cargada == true:
		global.current_scene = SAVE.game_data["Scene"]
		global.current_world = SAVE.game_data["World"]

#Función que regula el movimiento del personaje (direcciones, animaciones,
# velocidad, restricciones, etc).
func player_movement(delta):
	#Comprobamos para que no se mueva con diálogo activo.
	if !global.dialogue_running:
		if global.current_scene == "guitars_world":
			guitar_world_movement()
		elif global.current_scene == "trumpets_world":
			trumpet_world_movement()
		else:
			#Movimiento en el resto de los escenarios (2D vista cenital).
			if !attack_ip:
				if Input.is_action_pressed("Right"):
					current_dir = "right"
					play_anim(1)
					#if Input.is_action_pressed("Run"):
						#correr()
					#else:
					velocity.x = speed
					velocity.y = 0
				elif Input.is_action_pressed("Left"):
					current_dir = "left"
					play_anim(1)
					#if Input.is_action_pressed("Run"):
						#correr()
					#else:
					velocity.x = -speed
					velocity.y = 0
				elif Input.is_action_pressed("Down"):
					current_dir = "down"
					play_anim(1)
					#if Input.is_action_pressed("Run"):
						#correr()
					#else:
					velocity.y = speed
					velocity.x = 0
				elif Input.is_action_pressed("Up"):
					current_dir = "up"
					play_anim(1)
					#if Input.is_action_pressed("Run"):
						#correr()
					#else:
					velocity.y = -speed
					velocity.x = 0
				else:
					play_anim(0)
					velocity.x = 0
					velocity.y = 0
				
				move_and_slide()

#Función que regula el movimiento del personaje en el mundo de la Guitarra.
# Se baja la speed y se restringe el movimiento a dos direcciones, 
# pero se permite saltar.
func guitar_world_movement():
	if Input.is_action_pressed("Right"):
		if is_on_floor() and Input.is_action_just_pressed("Jump"):
			velocity.y -= jump
		current_dir = "right"
		play_anim(1)
		velocity.x = speed - 20
		velocity.y += gravity
	elif Input.is_action_pressed("Left"):
		if is_on_floor() and Input.is_action_just_pressed("Jump"):
			velocity.y -= jump
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed + 20
		velocity.y += gravity
	else:
		if is_on_floor() and Input.is_action_just_pressed("Jump"):
			velocity.y -= jump
		play_anim(0)
		velocity.x = 0
		velocity.y += gravity
		
	move_and_slide()

#Función que regula el movimiento del personaje en el mundo de la Trompeta.
# Se reduce considerablemente la speed del Jugador.
func trumpet_world_movement():
	if Input.is_action_pressed("Right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed - 40
		velocity.y = 0
	elif Input.is_action_pressed("Left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed + 40
		velocity.y = 0
	elif Input.is_action_pressed("Down"):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed - 40
		velocity.x = 0
	elif Input.is_action_pressed("Up"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -speed + 40
		velocity.x = 0
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()

#Coordina movimiento con las animaciones. Permite reproducir animaciones de
# diferentes skins de personaje.
func play_anim(movement):
	var dir = current_dir
	
	if dir == "right":
		animated_sprite.flip_h = false
		if movement == 1:
			anim = "side_walk"
		elif movement == 0:
			if attack_ip == false:
				anim = "side_idle"
	elif dir == "left":
		animated_sprite.flip_h = true
		if movement == 1:
			anim = "side_walk"
		elif movement == 0:
			if attack_ip == false:
				anim = "side_idle"
	elif dir == "down":
		if movement == 1:
			anim = "front_walk"
		elif movement == 0:
			if attack_ip == false:
				anim = "front_idle"
	elif dir == "up":
		if movement == 1:
			anim = "back_walk"
		elif movement == 0:
			if attack_ip == false:
				anim = "back_idle"
	
	animated_sprite.play(animation_prefix + anim)

#Cuando se llama, se asigna la velocidad maxspeed para poder correr en las
# cuatro direcciones.
#func correr():
	#if Input.is_action_pressed("Right"):
		#velocity.x = maxspeed
		#velocity.y = 0
	#elif Input.is_action_pressed("Left"):
		#velocity.x = -maxspeed
		#velocity.y = 0
	#elif Input.is_action_pressed("Down"):
		#velocity.x = 0
		#velocity.y = maxspeed
	#elif Input.is_action_pressed("Up"):
		#velocity.x = 0
		#velocity.y = -maxspeed

#Función que gestiona la acción de atacar en el mundo del Violoncello,
# con sonido, cooldown y animaciones.
func attack():
	var dir = current_dir
	
	if !global.dialogue_running:
		if global.current_scene == "cellos_world":
			if $Attack_sound.is_playing():
				pass
			elif Input.is_action_just_pressed("Attack"):
				global.player_current_attack = true
				attack_ip = true
				$Attack_sound.play()
				if dir == "right":
					animated_sprite.flip_h = false
					anim = "side_attack"
					$Deal_attack_timer.start()
				elif dir == "left":
					animated_sprite.flip_h = true
					anim = "side_attack"
					$Deal_attack_timer.start()
				elif dir == "down":
					anim = "front_attack"
					$Deal_attack_timer.start()
				elif dir == "up":
					anim = "back_attack"
					$Deal_attack_timer.start()

				animated_sprite.play(animation_prefix + anim)

#Reloj para espaciar los ataques.
func _on_deal_attack_timer_timeout():
	$Deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false
	
#Función que regula las diferentes cámaras que se usan en cada escenario.
func current_camera():
	if global.current_scene == "world_mono" or global.current_scene == "world_red" \
	or global.current_scene == "world_green" or global.current_scene == "world_yellow" \
	or global.current_scene == "world":
		$World_camera.enabled = true
		$Guitar_camera.enabled = false
		$Cello_camera.enabled = false
		$Cello_world_camera.enabled = false
		$Trumpet_camera.enabled = false
	elif global.current_scene == "guitars_house_mono" or global.current_scene == "guitars_house" \
	or global.current_scene == "trumpets_house_mono" or global.current_scene == "trumpets_house":
		$World_camera.enabled = false
		$Guitar_camera.enabled = true
		$Cello_camera.enabled = false
		$Cello_world_camera.enabled = false
		$Trumpet_camera.enabled = false
	elif global.current_scene == "cellos_house_mono" or global.current_scene == "cellos_house" \
	or global.current_scene == "school":
		$World_camera.enabled = false
		$Guitar_camera.enabled = false
		$Cello_camera.enabled = true
		$Cello_world_camera.enabled = false
		$Trumpet_camera.enabled = false
	elif global.current_scene == "cellos_world":
		$World_camera.enabled = false
		$Guitar_camera.enabled = false
		$Cello_camera.enabled = false
		$Cello_world_camera.enabled = true
		$Trumpet_camera.enabled = false
	elif global.current_scene == "trumpets_world":
		$World_camera.enabled = false
		$Guitar_camera.enabled = false
		$Cello_camera.enabled = false
		$Cello_world_camera.enabled = false
		$Trumpet_camera.enabled = true

#Cuando se interacciona con un objeto con el que existe opción de diálogo, se
# reproduce en la posición almacenada en global.dialogue_id.
func dialogue():
	if !global.dialogue_running and global.dialogue_id != "":
		if Input.is_action_just_pressed("Interaction"):
			DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), global.dialogue_id)
			return

