extends footSoldierEnemy

@onready var susB: PackedScene = preload("res://nodes/bullett.tscn")

func shoot():
    shouldMove = false
    await get_tree().create_timer(0.25).timeout
    var tempB: bullet = susB.instantiate() as bullet
    tempB.global_position = get_node("gun").global_position
    tempB.target = playerPos.position * 1000
    get_parent().add_child(tempB)
    await get_tree().create_timer(0.25).timeout
    shouldMove = true

func _on_timer_timeout():
    shoot()

func _ready():
    shoot()
