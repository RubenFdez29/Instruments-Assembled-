extends CanvasLayer

signal on_transition_finished

#Función que se ejecuta cada vez que se instancia la escena de Transición.
func _ready():
	$ColorRect.visible = false
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)

#Función que gestiona el fundido a negro y vuelta a la nueva escena.
func _on_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		on_transition_finished.emit()
		$AnimationPlayer.play("fade_to_normal")
	elif anim_name == "fade_to_normal":
		$ColorRect.visible = false

#Función con la que se instancia la escena de Transición.
func transition():
	$ColorRect.visible = true
	$AnimationPlayer.play("fade_to_black")

#Función con la que se reproduce el sonido de puerta al cambiar de escenas.
func door():
	$Door_sound.play()

