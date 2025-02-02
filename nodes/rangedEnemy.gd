extends footSoldierEnemy

@onready var susB: PackedScene = preload("res://nodes/bullett.tscn")
@onready var animacion: AnimationPlayer = get_node("AnimationPlayer")
@onready var rc: RayCast2D = get_node("RayCast2D")

func shoot():
	animacion.play("stopMove")
	shouldMove = false
	var tempB: bullet = susB.instantiate() as bullet
	tempB.global_position = get_node("sprites/Sprite2D5/Sprite2D6/gun").global_position
	tempB.target = (rc.target_position).normalized()
	await get_tree().create_timer(0.25).timeout
	get_tree().current_scene.add_child(tempB)
	await get_tree().create_timer(0.25).timeout
	shouldMove = true
	animacion.play("startMove")

func _on_timer_timeout():
	shoot()


func _process(delta):
	rc.target_position = to_local(playerPos.position)