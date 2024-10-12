extends CharacterBody2D

@export var speed : int # variable de velocidad de movimiento
@export var jumpForce : int # variable para la fuerza del salto
const GRAVITY = 16 # constante de gravedad en 16 ´
func _process(delta):
	motionCtrl()
	
func motionCtrl() -> void:
	velocity.y += GRAVITY
	if GLOBAL.getAxis().x == 1:
		$Sprite2D.flip_h = false
	elif GLOBAL.getAxis().x == -1:
		$Sprite2D.flip_h = true
	
	if GLOBAL.getAxis().x != 0:
		velocity.x = GLOBAL.getAxis().x * speed
	else:
		velocity.x = 0
	
	if is_on_floor():
		if GLOBAL.getAxis().x != 0:
			$AnimationPlayer.play("run")
		else:
			$AnimationPlayer.play("Idle")
	
		if Input.is_action_just_pressed("ui_accept"):
			$AnimationPlayer.play("jump")
			velocity.y -= jumpForce
	move_and_slide()
