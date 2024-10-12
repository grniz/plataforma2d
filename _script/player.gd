extends CharacterBody2D

@onready var animation = $AnimationPlayer
@onready var weaponFX = $WeaponFX

var speed : int = 150 # variable de velocidad de movimiento
@export var jumpForce : int # variable para la fuerza del salto
const GRAVITY = 16 # constante de gravedad en 16 parece funcionar bien
var canMove : bool = true:
	set(value):
		canMove = value
		if value == false:
			speed = 0
		else:
			speed = 150

@export var CurrentWeapon : Weapon:  # variable del arma setea los valores propios del arma equipada
	set(value):
		CurrentWeapon = value

var counter : int = 1 # numero del combo de golpe

  
func _process(delta):
	motionCtrl()
	
	
func motionCtrl() -> void:
	velocity.y += GRAVITY
	# gira los sprites deacuerdo para donde este mirando el personaje junto a su arma
	if GLOBAL.getAxis().x == 1:
		$PlayerSprite.flip_h = false
		$WeaponSprite.flip_h = false
	elif GLOBAL.getAxis().x == -1:
		$PlayerSprite.flip_h = true
		$WeaponSprite.flip_h = true

	if GLOBAL.getAxis().x != 0:
		velocity.x = GLOBAL.getAxis().x * speed
	else:
		velocity.x = 0
	if canMove:
		if is_on_floor():
			if GLOBAL.getAxis().x != 0:
				animation.play("run")
			else:
				animation.play("Idle")
	
			if Input.is_action_just_pressed("ui_accept"):
				animation.play("jump")
				velocity.y -= jumpForce
			if Input.is_action_pressed("attack"):
				playAnimation()
		move_and_slide()

#func inputAtk(event):
#	if event.is_action_pressed("attack"):
#		playAnimation()


func combo(animation):
	if animation in ["SwordAtk","DagaAtk", "Punch"]:
		return "" + str(counter)
	else:
		return ""

func playAnimation():
	canMove = false
	if CurrentWeapon == null:
		animation.play("Punch" + combo("Punch"))
	else:
		$WeaponSprite.texture = CurrentWeapon.texture
		weaponFX.play(CurrentWeapon.animation + combo(CurrentWeapon.animation))
		animation.play(CurrentWeapon.animation + combo(CurrentWeapon.animation))
	
	counter += 1
	if counter > 3:
		counter = 1


func _onAnimationFinished(anim_name):
	canMove = true
