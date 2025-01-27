class_name footSoldierEnemy extends owCharBod

var playerPos: player
var currentHp := 9
@onready var deathExplosionVfx = preload("res://nodes/particlesHit.tscn") as PackedScene
@onready var hitExplosionVfx = get_node("CPUParticles2D") as CPUParticles2D
var deathLim := true

func deathFx():
    print("asdasdasd")
    var currVfx = deathExplosionVfx.instantiate() as CPUParticles2D
    currVfx.position = position
    get_parent().add_child(currVfx)
    currVfx.emitting = true

func _ready():
    print("awake")

func _physics_process(delta):
    position = position.move_toward(playerPos.position,3)
    if playerPos.position.x > position.x:
        scale = Vector2(-1,1)
    else:
        scale = Vector2(1,1)

    if currentHp < 1 and deathLim == true:
        deathLim = false
        deathFx()
        queue_free()

func onHit():
    currentHp -= 3
    hitExplosionVfx.emitting = true

