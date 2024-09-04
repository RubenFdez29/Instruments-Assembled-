extends CharacterBody2D

#Función que se ejecuta al inicio cada vez que se instancia la escena 
# de la Trompeta. Repoduce su animación idle.
func _ready():
	$AnimatedSprite2D.play("idle")

#Cuando el Jugador entra en contacto con el área de detección de la Trompeta,
# se asigna a dialogue_id el código de inicio de la sección de texto que se 
# quiere reproducir.
func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		if global.current_scene == "trumpets_world":
			global.dialogue_id = "trumpets_world_end"
			if global.first_time:
				DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/Voices.dialogue"), "trumpets_world_end")
				global.first_time = false
		elif global.current_scene == "trumpets_house":
			global.dialogue_id = "trumpets_house"

#Cuando el Jugador sale del área de la Trompeta, se asigna a la variable
# dialogue_id el valor "" para evitar que se siga reproduciendo el diálogo.
func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		global.dialogue_id = ""

