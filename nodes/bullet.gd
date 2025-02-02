class_name bullet extends Sprite2D

var target: Vector2
var reverseInt := 1

func _physics_process(delta):
    position += target * 400 * delta * reverseInt