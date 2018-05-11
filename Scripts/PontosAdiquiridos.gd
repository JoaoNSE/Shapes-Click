extends Node2D

const SPD = -40
const RT = 80
const RT_INCREMENT = 10
var pontos

func _ready():
	get_node("Pontuação").text = str(pontos)
	set_process(true)

func _process(delta):
	position.y += SPD * delta
	get_node("Pontuação").rect_rotation += sin(get_node("Timer").time_left*RT_INCREMENT) * RT * delta
	
func _on_Timer_timeout():
	queue_free()
