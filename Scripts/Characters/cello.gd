extends CharacterBody2D

#Función que se ejecuta al inicio cada vez que se instancia la escena 
# del Violoncello. Repoduce su animación idle.
func _ready():
	$AnimatedSprite2D.play("idle")

#Cuando el Jugador entra en contacto con el área de detección del Cello,
# se asigna a dialogue_id el código de inicio de la sección de texto que se 
# quiere reproducir.
func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		global.dialogue_id = "cellos_house"

#Cuando el Jugador sale del área del Cello, se asigna a la variable
# dialogue_id el valor "" para evitar que se siga reproduciendo el diálogo.
func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		global.dialogue_id = ""

