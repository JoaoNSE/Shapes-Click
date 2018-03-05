extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var linha_preload = preload("res://Scenes/Linha.tscn")

var linha = null

var shapes
var pontos



func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	shapes = []
	pontos = []
	#get_parent().get_node("Linha").points.resize(0)

func _process(delta):
	if Input.is_action_pressed("ui_down"):
		print(shapes)
	
	if Input.is_action_pressed("Clique_Cancela"):
		limpar()
		
	if Input.is_action_pressed("Explode"):
		explode()
	
	if linha != null and shapes.size() > 0:
		linha.points = PoolVector2Array(pontos)
		

func add_shape(node):
	if shapes.empty() or shapes[-1].tipo == node.tipo:
		if !shapes.empty() and shapes.has(node):
			return
		shapes.append(node)
		pontos.append(node.position)
		node.set_selection(true)
		if linha == null:
			linha = linha_preload.instance()
			get_parent().add_child(linha)
	else:
		limpar()
		
func limpar():
	if linha != null:
		linha.queue_free()
		linha = null
	for s in shapes:
		s.set_selection(false)
	shapes.clear()
	pontos.clear()
	
func explode():
	for s in shapes:
		s.pontua()
	limpar()