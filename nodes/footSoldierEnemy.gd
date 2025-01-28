class_name footSoldierEnemy extends owCharBod

var playerPos: player
var currentHp := 9
@onready var deathExplosionVfx = preload("res://nodes/particlesHit.tscn") as PackedScene
@onready var hitExplosionVfx = get_node("CPUParticles2D") as CPUParticles2D
var deathLim := true
var shouldMove = true
@onready var healthBar = get_node("ProgressBar") as ProgressBar
var knockDir := Vector2(0,0)
var isKnocked := false
var knockVal := 0
@onready var debugCube = preload("res://debugcube.tscn")

func deathFx():
    var currVfx = deathExplosionVfx.instantiate() as CPUParticles2D
    currVfx.position = position
    get_parent().add_child(currVfx)
    currVfx.emitting = true

func stun():
    shouldMove = false
    isKnocked = true
    await get_tree().create_timer(0.25).timeout
    isKnocked = false
    shouldMove = true
    #knockDir = Vector2(0,0)
    knockVal = 0

func _physics_process(delta):
    if shouldMove == true:
        position = position.move_toward(playerPos.position,3)
    if playerPos.position.x > position.x:
        scale = Vector2(-1,1)
        healthBar.scale = Vector2(-1,1)
    else:
        scale = Vector2(1,1)
        healthBar.scale = Vector2(-1,1)

    if currentHp < 1 and deathLim == true:
        deathLim = false
        deathFx()
        queue_free()

    healthBar.value = currentHp
    if isKnocked == true:
        position = position.move_toward(knockDir,knockVal)

func onHit():
    knockDir = (position-playerPos.position) * 2
    knockVal = 4
    healthBar.visible = true
    currentHp -= 3
    hitExplosionVfx.emitting = true
    stun()