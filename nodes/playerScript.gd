extends CharacterBody2D

@export var speed := 250
@onready var footsiesAnim := get_node("feetAnim")
@onready var themHandsAnim := get_node("handsAnim")
var atkAnim := "down"

func getInput():
    var inputDirection = Input.get_vector("left","right","up","down")
    velocity = inputDirection * speed

func _process(delta):
    getInput()
    print(velocity)
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