extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var controller

var tipo = "Quadrado"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	controller = get_parent().get_node("Controller")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Quadrado_input_event(viewport, event, shape_idx):
	if event.is_action("Clique"):
		controller.add_shape(self)

func pontua():
	print("GANHOU PONTOOOS")
	queue_free()
