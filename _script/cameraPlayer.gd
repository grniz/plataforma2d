extends Camera2D

@export var PLAYER: Node2D

func _process(delta):
	global_position.x = PLAYER.global_position.x
