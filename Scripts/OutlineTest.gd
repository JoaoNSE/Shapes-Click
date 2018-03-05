extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var mate;

func _ready():
	print("caçial")
	material.set_shader_param("stepSizeX", 1.0/texture.get_width())
	material.set_shader_param("stepSizeY", 1.0/texture.get_height())
	
	



