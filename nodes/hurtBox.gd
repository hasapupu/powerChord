class_name hurtBox extends Area2D

func _init():
    collision_layer = 0
    collision_mask = 3

func _on_area_entered(area: hitBox):
    if area == null:
        return

    if get_parent() is player and area.is_in_group("playerHitbox") == false:
        var tempP = get_parent() as player
        tempP.currentHp -= 3
        if area.get_parent() is footSoldierEnemy:
            var tempGenE = area.get_parent() as footSoldierEnemy
            tempGenE.deathFx()
            tempGenE.queue_free()

    if get_parent() is bullet:
        var tempAH = get_parent() as bullet
        if area.get_parent().is_in_group("player"):
            (area.get_parent() as player).currentHp -= 2
            get_parent().queue_free()

    if get_parent() is footSoldierEnemy:
        var tempE = get_parent() as footSoldierEnemy
        if area.is_in_group("enemyHitbox") == false:
            tempE.onHit()
