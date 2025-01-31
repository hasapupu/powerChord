class_name bullet extends Sprite2D

var target: Vector2

func _physics_process(delta):
    global_position = global_position.move_toward(Vector2(target.x,target.y + 40),14)