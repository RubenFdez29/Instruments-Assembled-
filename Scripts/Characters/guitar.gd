extends CharacterBody2D

#Función que se ejecuta al inicio cada vez que se instancia la escena 
# de la Guitarra. Repoduce su animación idle.
func _ready():
	$AnimatedSprite2D.play("idle")

#Cuando el Jugador entra en contacto con el área de detección de la Guitarra,
# se asigna a dialogue_id el código de inicio de la sección de texto que se 
# quiere reproducir.
func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		if global.current_scene == "guitars_world":
			global.dialogue_id = "guitars_world"
		elif global.current_scene == "guitars_house":
			global.dialogue_id = "guitars_house"

#Cuando el Jugador sale del área de la Guitarra, se asigna a la variable
# dialogue_id el valor "" para evitar que se siga reproduciendo el diálogo.
func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		global.dialogue_id = ""

