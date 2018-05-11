extends Node2D

export(float) var delay = 1.0
export(float) var x_min
export(float) var x_max

var q = preload("res://Scenes/Quadrado.tscn")
var t = preload("res://Scenes/Triangulo.tscn")

var shapes = [t, t, t, q]

var shape_exit
var timer


func _ready():
	shape_exit = get_node("shape_exit")
	timer = get_node("Timer")
	timer.wait_time = delay
	timer.start()
	#set_process(true)

#func _process(delta):
#	pass


func _on_Timer_timeout():
	var x = rand_range(x_min, x_max)
	shape_exit.position.x = shape_exit.get_parent().position.x + x
	shape_exit.position.y = shape_exit.get_parent().position.y
	print(x)
	
	var i = rand_range(0, shapes.size())
	var shap = shapes[i].instance()
	shap.position = shape_exit.position
	randomize()
	shap.speed = rand_range(shap.speed-shap.speed*0.3, shap.speed+shap.speed*0.3)
	get_parent().add_child(shap)
	pass # replace with function body
