class_name EditablePlayer extends CharacterBody2D


#To tell the character it was made this variable is used. Just changing it will allow the physics to work.
#A more proper implementation of this idea would be creating a different object in charge of showing 
#a previsualization of the model and then instatiating the player character through a constructor with the proper body parts
@onready var created = false
@onready var walking = false:
	set(value):
		if value == walking:
			return
		walking = value
		if(walking):
			startMovingAnimation()
		else:
			startIdleAnimation()

#we save each part on a dictionary for an easier time controlling them 
@onready var body = {
	"head":$Head,
	"leg_l":$Leg_L,
	"arm_l":$Arm_L,
	"body":$Body,
	"leg_r":$Leg_R,
	"arm_r":$Arm_R
	}

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func startMovingAnimation() -> void:
	for e in body:
		body[e].play("moving")

func startIdleAnimation() -> void:
	for e in body:
		body[e].play("idle")

func flip_whole_h(value:bool) -> void:
	for e in body:
		body[e].flip_h = value

func _physics_process(delta: float) -> void:
	if !created:
		return
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
	if(velocity.x == 0):
		walking = false
	elif (velocity.x != 0):
		walking = true
		if(velocity.x < 0):
			flip_whole_h(true)
		elif(velocity.x > 0):
			flip_whole_h(false)


func swap_body_part(body_part:String, asprite:SpriteFrames):
	if(!body_part in body):
		print("invalid part")
		return
	body[body_part].sprite_frames = asprite

func creation_finished():
	created = true
