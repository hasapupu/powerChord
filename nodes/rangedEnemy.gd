extends footSoldierEnemy

@onready var susB: PackedScene = preload("res://nodes/bullett.tscn")
@onready var animacion: AnimationPlayer = get_node("AnimationPlayer")

func shoot():
	animacion.play("stopMove")
	shouldMove = false
	var tempB: bullet = susB.instantiate() as bullet
	tempB.global_position = get_node("Sprite2D5/Sprite2D6/gun").global_position
	tempB.target = playerPos.global_position * 1000
	await get_tree().create_timer(0.25).timeout
	get_parent().add_child(tempB)
	await get_tree().create_timer(0.25).timeout
	shouldMove = true
	animacion.play("startMove")

func _on_timer_timeout():
	shoot()

func _ready():
	shoot()
