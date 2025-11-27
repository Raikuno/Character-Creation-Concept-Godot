extends CanvasLayer

@onready var player = $Player
@onready var menu = $Menu

#We connect the signal with the respective function on the character
func _ready() -> void:
	menu.connect("swap", player.swap_body_part)
	menu.connect("created", player.creation_finished)
