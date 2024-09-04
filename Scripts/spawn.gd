extends Node2D

const ROTATION_SPEED = 1

#Gestiona la velocidad de rotación del asset del spawn de enemigos.
func _process(delta):
	rotation += ROTATION_SPEED * delta

