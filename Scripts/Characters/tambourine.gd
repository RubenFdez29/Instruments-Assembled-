extends CharacterBody2D

#Función que se ejecuta al inicio cada vez que se instancia la escena 
# de la Pandereta. Repoduce su animación idle.
func _ready():
	$AnimatedSprite2D.play("idle")

