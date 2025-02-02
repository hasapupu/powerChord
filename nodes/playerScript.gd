class_name player extends owCharBod

@export var speed := 250
@onready var footsiesAnim := get_node("feetAnim")
@onready var themHandsAnim := get_node("handsAnim")
var atkAnim := "down"
var currentHp = 100
var maxHp = 100
@onready var healthBar: ProgressBar = get_parent().get_node("TextureProgressBar")
var shouldMove := false
var strInv := ["dash"]
var uiParents := []


func _ready():
	for i in range(5):
		uiParents.append(get_parent().get_node("uiParent"+str(i)))

func getInput():
	var inputDirection = Input.get_vector("left","right","up","down")
	velocity = inputDirection * speed

func _physics_process(delta):
	if shouldMove == true:
		getInput()
		move_and_slide()
		if velocity == Vector2(0,0):
			footsiesAnim.play("playerIdle")
			atkAnim = "down"
		else:
			if velocity.y > 80:
				footsiesAnim.play("forwardWalk")
				atkAnim = "down"
			elif velocity.y < -80:
				footsiesAnim.play("backWalk")
				atkAnim = "up"
			else:
				if velocity.x > 80:
					footsiesAnim.play("rightWalk")
					atkAnim = "right"
				elif velocity.x < -80:
					footsiesAnim.play("leftWalk")
					atkAnim = "left"

		if Input.is_action_just_pressed("basicAttack"):
			themHandsAnim.play(atkAnim + "hit")
		elif Input.is_action_just_pressed("dash"):
			if strInv.has("dash"):
				speed = 350
				get_node("Area2D/CollisionShape2D").disabled = true
				get_node("shield").visible = true
				await get_tree().create_timer(0.7).timeout
				speed = 250
				get_node("Area2D/CollisionShape2D").disabled = false
				get_node("shield").visible = false
			pass
		elif Input.is_action_just_pressed("overheadSlam"):
			if strInv.has("overheadSlam"):
				pass
			pass
		elif Input.is_action_just_pressed("swing"):
			if strInv.has("swing"):
				themHandsAnim.play(atkAnim + "parry")
		elif Input.is_action_just_pressed("slowArea"):
			if strInv.has("slowArea"):
				pass
			pass
		elif Input.is_action_just_pressed("projectile"):
			if strInv.has("projectile"):

				pass
			pass
		setZindex()
	else:
		pass
	
func _process(delta):
	healthBar.value = currentHp
