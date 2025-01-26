class_name footSoldierEnemy extends owCharBod

var playerPos: Node2D

func _ready():
    print("awake")

func _physics_process(delta):
    position = position.move_toward(playerPos.position,3)
    if playerPos.position.x > position.x:
        scale = Vector2(-1,1)
    else:
        scale = Vector2(1,1)

    setZindex()

func modClamp(inp: Vector2) -> Vector2:
    var xd := inp.x
    var yd := inp.y
    while xd > 1 or xd < -1:
        xd /= 10
    while yd > 1 or yd < -1:
        yd /= 10
    return Vector2(xd,yd)