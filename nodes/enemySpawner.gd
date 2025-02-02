class_name enemySpawner extends Node2D

@onready var basicEnemy: PackedScene = preload("res://nodes/footSoldierEnemy.tscn")
@onready var kysRangedEnemy: PackedScene = preload("res://nodes/rangedEnemy.tscn")
@onready var playerGO = get_parent().get_node("player") 
@onready var bruhTimer: Timer = get_node("Timer")
var timeUntilSpawn = 3 
var spawnLocs := [Vector2(450,20),Vector2(-450,20)]
@onready var enemies := [kysRangedEnemy]

func instantiateBasicEnemy():
	var tempGoon = enemies.pick_random()
	enemies = [kysRangedEnemy,basicEnemy]
	var currentBE: footSoldierEnemy = tempGoon.instantiate() as footSoldierEnemy
	currentBE.playerPos = playerGO as player 
	currentBE.position = spawnLocs.pick_random()
	add_child(currentBE)

func _on_timer_timeout():
	timeUntilSpawn -= 0.01
	bruhTimer.wait_time = timeUntilSpawn
	instantiateBasicEnemy()
