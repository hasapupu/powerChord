extends Node2D

@onready var basicEnemy: PackedScene = preload("res://nodes/rangedEnemy.tscn")
@onready var playerGO = get_parent().get_node("player") 
@onready var bruhTimer: Timer = get_node("Timer")
var timeUntilSpawn = 3 

func instantiateBasicEnemy():
	var currentBE: footSoldierEnemy = basicEnemy.instantiate()
	currentBE.playerPos = playerGO as player 
	currentBE.position = Vector2(randi_range(-409,410),0)
	add_child(currentBE)

func _on_timer_timeout():
	timeUntilSpawn -= 0.01
	bruhTimer.wait_time = timeUntilSpawn
	instantiateBasicEnemy()
