class_name daddyMaster extends Node2D

@onready var spawnerOfEnemies: enemySpawner = get_node("Node2D2")
@onready var playChar: player = get_node("player")
@onready var startScreen = get_node("Control")
@onready var deathScreen = preload("res://nodes/gameOverScreen.tscn")
var shouldBeChecking := true

func startGameplay():
    spawnerOfEnemies.bruhTimer.start()
    #playChar.shouldMove = true
    startScreen.queue_free()
    playChar.footsiesAnim.pause()


func _on_start_button_down():
    startGameplay()

func _on_quit_button_down():
    get_tree().quit()

func _process(delta):
    if shouldBeChecking == true:
        if playChar.currentHp < 1:
            shouldBeChecking = false
            for i in get_children():
                i.queue_free()
            add_child(deathScreen.instantiate())