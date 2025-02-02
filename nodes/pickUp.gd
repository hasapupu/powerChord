class_name pickUp extends Sprite2D

var stringConst: String
@onready var collShape = get_node("Area2D/CollisionShape2D")

func _ready():
	stringConst = daddyMaster.uncollectedItems.pick_random()
	daddyMaster.uncollectedItems.erase(stringConst)

func _on_body_entered(body):
	if body is player:
		var tempP := body as player
		collShape.disabled = true
		reparent(tempP)
		position = Vector2(0,-100)
		await get_tree().create_timer(1.0).timeout
		reparent(tempP.uiParents[tempP.strInv.size()])
		move_to(Vector2(0,0),1,Vector2(1,1))
		await get_tree().create_timer(1.0).timeout
		tempP.strInv.append(stringConst)

func move_to(target_position: Vector2, duration: float, target_scale: Vector2 = scale, use_local_coords: bool = true) -> void:
	var tween = create_tween()
	if use_local_coords:
		tween.tween_property(self, "position", target_position, duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	else:
		tween.tween_property(self, "global_position", target_position, duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale", target_scale, duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
