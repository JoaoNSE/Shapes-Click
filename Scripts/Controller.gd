extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var linha_preload = preload("res://Scenes/Linha.tscn")

var linha = null

#lista de shapes
var shapes
#lista das posições dos shapes
var pontos

#numero de pontos do jogador
var player_points = 0
var n_destroyed = 0

var GUI
var pontosLabel

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	GUI = get_parent().get_node("CanvasLayer/GUI")
	pontosLabel = GUI.get_node("HBoxContainer/Panel/Pontos_lbl")
	set_process(true)
	shapes = []
	pontos = []
	#get_parent().get_node("Linha").points.resize(0)

func _process(delta):
	pontosLabel.text = str(player_points)
	if Input.is_action_pressed("ui_down"):
		print(shapes)
	
	if Input.is_action_pressed("Clique_Cancela"):
		limpar()
		
	if Input.is_action_pressed("Explode"):
		explode()
	
	if linha != null and shapes.size() > 0:
		for i in range(shapes.size()):
			pontos[i] = shapes[i].position
			
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
	n_destroyed = 0
	if linha != null:
		linha.queue_free()
		linha = null
	for s in shapes:
		s.set_selection(false)
	shapes.clear()
	pontos.clear()
	
func explode():
	for i in range(shapes.size()):
		if i == shapes.size()-1:
			shapes[i].last = true
		shapes[i].pontua()
	limpar()
	n_destroyed = 0