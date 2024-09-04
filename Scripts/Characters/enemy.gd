extends CharacterBody2D

var health = 100
var speed = 100
var player = null
var player_chase = false
var player_inattack_zone = false
var can_take_damage = true

#Función iterativa que llama a las funciones que habilitan las diferentes
# mecánicas relacionadas con el mundo, el Jugador y las físicas.
func _physics_process(delta):
	deal_with_damage()
	update_health()
	
	#Si el Jugador está en su área de detección, le persigue reproduciendo su
	# animación de caminar.
	if player_chase:
		#Regula la velocidad en función de la distancia al Jugador.
		#Cuanto más lejos, más rápido.
		position += (player.position - position)/speed
		move_and_collide(Vector2(0,0))
		$AnimatedSprite2D.play("walk")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")

#Función que lo denomina como Enemigo
func enemy():
	pass

#Cuando detecta un cuerpo en su área de detección, lo marca y pone a true
# la persecución.
func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

#Cuando deja de detectar el cuerpo, lo desmarca y pone a false
# la persecución.
func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

#Función que detecta el inicio de la colisión entre las hitbox 
# de Enemigo y Jugador.
func _on_enemy_hit_box_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true

#Función que detecta el fin de la colisión entre las hitbox 
# de Enemigo y Jugador.
func _on_enemy_hit_box_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false

#Función para recibir daño del Jugador. Reproduce la animación de morir cuando
# la salud llega a 0.
func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			$take_damage_cooldown.start()
			can_take_damage = false
			if health <= 0:
				$AnimatedSprite2D.play("death")
				global.enemy_kill += 1
				self.queue_free()

#Reloj para espaciar el posible daño recibido.
func _on_take_damage_cooldown_timeout():
	can_take_damage = true

#Muestra la barra de salud al empezar a recibir daño.
func update_health():
	var healthbar = $Healthbar
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true

