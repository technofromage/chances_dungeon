extends CanvasLayer

var player:KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent()

func _process(delta):
	$HealthLbl.text = "Health:%d/%d"%[player.StatBlock.health,player.StatBlock.maxHealth]
	$HealthBar.value = player.StatBlock.health

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
