extends CanvasLayer

var player:KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent()
	$HealthBar.rect_size=Vector2(32*player.StatBlock.maxHealth, 16)

func _process(delta):
	$HealthLbl.text = "Health:%d/%d"%[player.StatBlock.health,player.StatBlock.maxHealth]
	
	$HealthBar/Value.rect_size=Vector2(32*player.StatBlock.health, 16)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
	Music.inGame = false
	Music.fadeout = true
