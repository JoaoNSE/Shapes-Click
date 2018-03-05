extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var controller

var tipo = "Quadrado"

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