class_name player extends owCharBod

@export var speed := 250
@onready var footsiesAnim := get_node("feetAnim")
@onready var themHandsAnim := get_node("handsAnim")
var atkAnim := "down"
var currentHp = 100
var maxHp = 100
@onready var healthBar: ProgressBar = get_parent().get_node("TextureProgressBar")

func getInput():
	var inputDirection = Input.get_vector("left","right","up","down")
	velocity = inputDirection * speed

func _physics_process(delta):
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

	setZindex()
	
func _process(delta):
	healthBar.value = currentHp
