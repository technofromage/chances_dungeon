extends Sprite
tool
export var weapon:Resource setget loadWeapon
const itemType = "weapon"

func _ready():
	weapon = weapon.duplicate()

func loadWeapon(value:Resource):
	rotation_degrees = (randi()%360)
	texture = value.sprite
	weapon = value
