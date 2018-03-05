extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var controller

export(String) var tipo
export(int) var pontos
export(float) var multiplicador

var canHoverDeselect = true

func _ready():
	controller = get_parent().get_node("Controller")
	#GAMBIARRA PRA FAZER O SHADER NÃO AFETAR OS OUTROS
	#OBJETOS QUE COMPARTILHAM O MESMO SHADER
	var temp_mat = material.duplicate()
	material = temp_mat
	
	
func _on_Quadrado_input_event(viewport, event, shape_idx):
	if event.is_action("Clique"):
		controller.add_shape(self)

func pontua():
	print("GANHOU PONTOOOS")
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
