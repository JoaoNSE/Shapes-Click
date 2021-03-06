extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

#Components
var controller


#preloads
var particleSys = preload("res://Scenes/ShapesParticleSys.tscn")
var pontosAdiquiridosLabel = preload("res://Scenes/PontosAdiquiridos.tscn")

#Eports
export(String) var tipo
export(int) var pontos
export(int) var multiplicador
export(float) var speed = 0.0

var canHoverDeselect = true
var last = false

func _ready():
	controller = get_parent().get_node("Controller")
	#GAMBIARRA PRA FAZER O SHADER NÃO AFETAR OS OUTROS
	#OBJETOS QUE COMPARTILHAM O MESMO SHADER
	var temp_mat = material.duplicate()
	material = temp_mat
	set_process(true)
	
func _process(delta):
	position.y += speed
	
	
func _on_Quadrado_input_event(viewport, event, shape_idx):
	if event.is_action("Clique"):
		controller.add_shape(self)

func pontua():
	var points_add = pontos + multiplicador*controller.n_destroyed
	controller.player_points += points_add
	if last:
		var pal = pontosAdiquiridosLabel.instance()
		pal.pontos = points_add
		pal.position = position
		get_parent().add_child(pal)
	
	controller.n_destroyed += 1
	
	var part = particleSys.instance()
	part.position = position
	part.emitting = true
	get_parent().add_child(part)
	
	queue_free()
	
func set_selection(selection):
	material.set_shader_param("active", selection)
	canHoverDeselect = !selection

func set_hover_selection(selection):
	material.set_shader_param("active", selection)
	canHoverDeselect = true
	
func _on_Shape_mouse_entered():
	if canHoverDeselect:
		set_hover_selection(true)
	
func _on_Shape_mouse_exited():
	if canHoverDeselect:
		set_hover_selection(false)
