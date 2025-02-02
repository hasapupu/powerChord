class_name pickUp extends Sprite2D

var stringConst: String
@onready var collShape = get_node("Area2D/CollisionShape2D")
var namesDict = {"dash":"Invul","overheadSlam":"Ultimate","swing":"Parry","slowArea":"Slow","projectile":"Shoot"}
@onready var time: Timer = get_node("Timer")
@onready var tesu: RichTextLabel = get_node("RichTextLabel")
var playerChar: player
var lengths = {"dash":2,"overheadSlam":30,"swing":1,"slowArea":10,"projectile":3}

func _ready():
	stringConst = daddyMaster.uncollectedItems.pick_random()
	daddyMaster.uncollectedItems.erase(stringConst)

func _process(delta):
	if time.is_stopped() == false:
		tesu.text = str(round(time.time_left))
		print(time.is_stopped())
	else:
		tesu.text = namesDict[stringConst]
		

func _on_timer_timeout():
	playerChar.namesDict[stringConst] = false

func _on_body_entered(body):
	if body is player:
		playerChar = body as player
		playerChar.coolDowns[stringConst] = self
		collShape.disabled = true
		reparent(playerChar)
		position = Vector2(0,-100)
		await get_tree().create_timer(1.0).timeout
		reparent(playerChar.uiParents[playerChar.strInv.size()])
		move_to(Vector2(0,0),1,Vector2(1,1))
		await get_tree().create_timer(1.0).timeout
		playerChar.strInv.append(stringConst)

func startCoolDown():
	time.wait_time = lengths[stringConst]
	time.start()

func move_to(target_position: Vector2, duration: float, target_scale: Vector2 = scale, use_local_coords: bool = true) -> void:
	var tween = create_tween()
	if use_local_coords:
		tween.tween_property(self, "position", target_position, duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	else:
		tween.tween_property(self, "global_position", target_position, duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale", target_scale, duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
