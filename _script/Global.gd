extends Node

# variable del eje de posicion
var axis : Vector2

# funcion que retorna la direcion pulsada
func getAxis() -> Vector2:
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down"))
	return axis.normalized()
