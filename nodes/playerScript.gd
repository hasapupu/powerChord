class_name player extends owCharBod

@export var speed := 250
@onready var footsiesAnim := get_node("feetAnim")
@onready var themHandsAnim := get_node("handsAnim")
var atkAnim := "down"
var currentHp = 100
var maxHp = 100
@onready var healthBar: ProgressBar = get_parent().get_node("TextureProgressBar")
var shouldMove := false
var strInv := []
var uiParents := []
@onready var slowAr = preload("res://nodes/slowzone.tscn")
@onready var proj = preload("res://nodes/playerBullet.tscn")
var inputDirection: Vector2
@onready var gunRay = get_node("RayCast2D")
var namesDict = {"dash":false,"overheadSlam":false,"swing":false,"slowArea":false,"projectile":false}
var coolDowns := {}

func _ready():
	for i in range(5):
		uiParents.append(get_parent().get_node("uiParent"+str(i)))

func getInput():
	inputDirection = Input.get_vector("left","right","up","down")
	velocity = inputDirection * speed

func _physics_process(delta):
	if shouldMove == true:
		getInput()
		move_and_slide()
		if velocity == Vector2(0,0):
			footsiesAnim.play("playerIdle")
			atkAnim = "down"
			gunRay.target_position = Vector2(0,50)
		else:
			if velocity.y > 80:
				footsiesAnim.play("forwardWalk")
				atkAnim = "down"
				gunRay.target_position = Vector2(0,50)
			elif velocity.y < -80:
				footsiesAnim.play("backWalk")
				atkAnim = "up"
				gunRay.target_position = Vector2(0,-50)
			else:
				if velocity.x > 80:
					footsiesAnim.play("rightWalk")
					atkAnim = "right"
					gunRay.target_position = Vector2(50,0)
				elif velocity.x < -80:
					footsiesAnim.play("leftWalk")
					atkAnim = "left"
					gunRay.target_position = Vector2(-50,0)

		if Input.is_action_just_pressed("basicAttack"):
			themHandsAnim.play(atkAnim + "hit")
		elif Input.is_action_just_pressed("dash"):
			if strInv.has("dash") and namesDict["dash"] == false:
				namesDict["dash"] = true
				coolDowns["dash"].startCoolDown()
				speed = 350
				get_node("Area2D/CollisionShape2D").disabled = true
				get_node("shield").visible = true
				await get_tree().create_timer(0.7).timeout
				speed = 250
				get_node("Area2D/CollisionShape2D").disabled = false
				get_node("shield").visible = false
			pass
		elif Input.is_action_just_pressed("overheadSlam"):
			if strInv.has("overheadSlam") and namesDict["overheadSlam"] == false:
				namesDict["overheadSlam"] = true
				coolDowns["overheadSlam"].startCoolDown()
				get_tree().root.get_node("Node2D").ult()
			pass
		elif Input.is_action_just_pressed("swing"):
			if strInv.has("swing") and namesDict["swing"] == false:
				namesDict["swing"] = true
				coolDowns["swing"].startCoolDown()
				themHandsAnim.play(atkAnim + "parry")
		elif Input.is_action_just_pressed("slowArea"):
			if strInv.has("slowArea") and namesDict["slowArea"] == false:
				namesDict["slowArea"] = true
				coolDowns["slowArea"].startCoolDown()
				var tempA = slowAr.instantiate()
				tempA.global_position = global_position
				get_parent().add_child(tempA)
			pass
		elif Input.is_action_just_pressed("projectile"):
			if strInv.has("projectile") and namesDict["projectile"] == false:
				namesDict["projectile"] = true
				coolDowns["projectile"].startCoolDown()
				var tempB = proj.instantiate() as bullet
				tempB.target = gunRay.target_position / 10
				tempB.global_position = gunRay.target_position + global_position
				get_parent().add_child(tempB)
			pass
		setZindex()
	else:
		pass
	
func _process(delta):
	healthBar.value = currentHp
