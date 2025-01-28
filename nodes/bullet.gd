class_name bullet extends Sprite2D

var target: Vector2

func _physics_process(delta):
    position = position.move_toward(target,14)