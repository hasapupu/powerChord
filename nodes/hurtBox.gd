class_name hurtBox extends Area2D

@onready var cam: shakeableCamera = Engine.get_main_loop().root.get_node("Node2D").get_node("Camera2D")

func _init():
    collision_layer = 0
    collision_mask = 3

func _on_area_entered(area: hitBox):
    if area == null:
        return

    if get_parent() is player and area.is_in_group("playerHitbox") == false:
        var tempP = get_parent() as player
        tempP.currentHp -= 3
        tempP.shouldMove = true
        tempP.healthBar.visible = true
        tempP.themHandsAnim.play("RESET")
        if area.get_parent() is footSoldierEnemy:
            var tempGenE = area.get_parent() as footSoldierEnemy
            tempGenE.deathFx()
            tempGenE.queue_free()
            cam.trauma = 0.9
            cam.shake()
        elif area.get_parent() is bullet:
            var tempB = area.get_parent() as bullet
            tempB.queue_free()
            cam.trauma = 0.6
            cam.shake()
			

    if get_parent() is footSoldierEnemy:
        var tempE = get_parent() as footSoldierEnemy
        if area.is_in_group("enemyHitbox") == false:
            tempE.onHit()
            cam.trauma = 0.6
            cam.shake()
