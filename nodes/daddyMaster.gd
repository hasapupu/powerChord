class_name daddyMaster extends Node2D

@onready var spawnerOfEnemies: enemySpawner = get_node("factory")
@onready var playChar: player = get_node("player")
@onready var startScreen = get_node("Control")
@onready var deathScreen = preload("res://nodes/gameOverScreen.tscn")
var shouldBeChecking := true
static var uncollectedItems = ["dash","overheadSlam","swing","slowArea","projectile"]
static var odds = 1
@onready var winScene = preload("res://nodes/winScreen.tscn")
@onready var ultAnim = get_node("ultAnim")
@onready var sfxPlayer = get_node("sfxPlayer")
@onready var musicPlayer = get_node("musicPlayer")
@onready var riff: AudioStream = preload("res://GUTIAR RIFF.wav")
@onready var mainMusic: AudioStream = preload("res://HEAVY METAL TYPE OF SONG FULL SONG.ogg")
@onready var winSong: AudioStream = preload("res://WINNER!!.ogg")

func ult():
	musicPlayer.stream_paused = true
	get_tree().paused = true
	ultAnim.play("ulti")
	

func startGameplay():
	spawnerOfEnemies.bruhTimer.start()
	#playChar.shouldMove = true
	startScreen.queue_free()
	playChar.footsiesAnim.pause()


func _on_start_button_down():
	musicPlayer.stream_paused = true
	startGameplay()

func _on_quit_button_down():
	get_tree().quit()

func _process(delta):
	if shouldBeChecking == true:
		if playChar.currentHp < 1:
			musicPlayer.queue_free()
			shouldBeChecking = false
			for i in get_children():
				i.queue_free()
			spawnerOfEnemies.bruhTimer.paused = true
			add_child(deathScreen.instantiate())
		if playChar.strInv.size() > 4:
			shouldBeChecking = false
			spawnerOfEnemies.bruhTimer.paused = true
			playChar.shouldMove = false
			musicPlayer.stream_paused = true
			playChar.themHandsAnim.pause()
			playChar.footsiesAnim.pause()
			for i in spawnerOfEnemies.get_children():
				if i is footSoldierEnemy:
					var tempFoot = i as footSoldierEnemy
					tempFoot.shouldMove = false
			await get_tree().create_timer(1.0).timeout
			for i in spawnerOfEnemies.get_children():
				if i is footSoldierEnemy:
					var tempFoot = i as footSoldierEnemy
					tempFoot.deathFx()
					i.queue_free()
			await get_tree().create_timer(0.5).timeout
			for i in playChar.uiParents:
				var tempGoon = i.get_node("pickUp")
				tempGoon.move_to(Vector2(0,0),3,Vector2(1,1),false)
			await get_tree().create_timer(3.1).timeout
			var aa = winScene.instantiate()
			aa.position = Vector2(-480,-259)
			add_child(aa)
			musicPlayer.stream = winSong
			musicPlayer.stream_paused = false
			musicPlayer.playing = true

func _on_animation_finished(anim_name):
	if anim_name == "ulti":
		musicPlayer.stream = riff
		musicPlayer.stream_paused = false
		musicPlayer.playing = true

func _on_music_player_finished():
	if musicPlayer.stream == riff:
		get_tree().paused = false
		for i in spawnerOfEnemies.get_children():
			if i is footSoldierEnemy:
				var tempFoot = i as footSoldierEnemy
				tempFoot.deathFx()
				i.queue_free()
		ultAnim.play("rest")
		musicPlayer.stream = mainMusic
		musicPlayer.stream_paused = false
		musicPlayer.playing = true
		playChar.namesDict["overheadSlam"] = false


func _on_controls_button_down():
	get_node("Control/Button2").queue_free()