extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var velocidade = 100 setget setVelocidade, getVelocidade

var explosao
var expTimer

var opacity_step
var emiting = false

var pontuacao = 10

func _ready():
	explosao = get_node("Explosao")
	expTimer = get_node("ExpTimer")
	expTimer.connect("timeout", self, "end_destroi")
	opacity_step = 1/explosao.get_emit_timeout()
	set_process(true)
	
func destroi():
	explosao.set_emitting(true)
	expTimer.set_wait_time(explosao.get_emit_timeout()+1)
	expTimer.start()
	get_node("Colisao").queue_free()
	emiting = true
	
func end_destroi():
	queue_free()

func _process(delta):
	if !emiting:
		var pos = get_global_pos()
		pos.y += velocidade*delta
		set_global_pos(pos)
	else:
		explosao.set_opacity(explosao.get_opacity() - opacity_step*delta)
	
func setVelocidade(vel):
	velocidade = vel
	
func getVelocidade():
	return velocidade

func _on_Colisao_body_enter( body ):
	if body.get_name() == "Player":
		body.get_node("PlayerHealth").causa_dano(25)
		destroi()
