extends Node2D

@onready var basicEnemy: PackedScene = preload("res://nodes/footSoldierEnemy.tscn")
@onready var kysRangedEnemy: PackedScene = preload("res://nodes/rangedEnemy.tscn")
@onready var playerGO = get_parent().get_node("player") 
@onready var bruhTimer: Timer = get_node("Timer")
var timeUntilSpawn = 3 
var spawnLocs := [Vector2(450,20),Vector2(-450,20)]

func instantiateBasicEnemy():
	var tempGoon = [basicEnemy,kysRangedEnemy].pick_random()
	var currentBE: footSoldierEnemy = tempGoon.instantiate() as footSoldierEnemy
	currentBE.playerPos = playerGO as player 
	currentBE.position = spawnLocs.pick_random()
	add_child(currentBE)

func _on_timer_timeout():
	timeUntilSpawn -= 0.01
	bruhTimer.wait_time = timeUntilSpawn
	instantiateBasicEnemy()
