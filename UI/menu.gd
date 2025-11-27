class_name Menu extends CanvasLayer

signal swap(body_part:String, asprite:SpriteFrames)
signal created
#we save each body part in an array. We have to make sure that each string on this array can be found as a key in the body array of the player
const BODY_PARTS = ["head", "body", "arm_r", "arm_l", "leg_r", "leg_l"]
var body_pointer = 0

#For an easier management we use the values on the body_parts array as keys.
#We then save as a values the direction in the files to the resource of the different types of the specified body part
const RESOURCES = {
	"head":[
		"res://Character/sprite_frames/Heads/red.tres",
		"res://Character/sprite_frames/Heads/green.tres",
		"res://Character/sprite_frames/Heads/blue.tres"
		
	],
	"body":[
		"res://Character/sprite_frames/Body/red.tres",
		"res://Character/sprite_frames/Body/green.tres",
		"res://Character/sprite_frames/Body/blue.tres"
		
	],
	"arm_r":[
		"res://Character/sprite_frames/arm_r/red.tres",
		"res://Character/sprite_frames/arm_r/green.tres",
		"res://Character/sprite_frames/arm_r/blue.tres"
		
	],
	"arm_l":[
		"res://Character/sprite_frames/arm_l/red.tres",
		"res://Character/sprite_frames/arm_l/green.tres",
		"res://Character/sprite_frames/arm_l/blue.tres"
		
	],
	"leg_r":[
		"res://Character/sprite_frames/leg_r/red.tres",
		"res://Character/sprite_frames/leg_r/green.tres",
		"res://Character/sprite_frames/leg_r/blue.tres"
		
	],
	"leg_l":[
		"res://Character/sprite_frames/leg_l/red.tres",
		"res://Character/sprite_frames/leg_l/green.tres",
		"res://Character/sprite_frames/leg_l/blue.tres"
		
	]
}
var resources_pointer = 0

@onready var label = $Label

#Changing the body part being edited and the type of that bodypart is as simple as adding or substracting 1
# to the respective pointer and clamping the result so that the value is always 0 at min and the amount of body parts/types as max (we substract 1 of this number to get the final element of the array)
# We then send the neccesary values through a signal

func next_type() -> void:
	resources_pointer += 1
	resources_pointer = clamp(resources_pointer, 0, RESOURCES[BODY_PARTS[body_pointer]].size() - 1)
	emit_signal("swap",BODY_PARTS[body_pointer], load(RESOURCES[BODY_PARTS[body_pointer]][resources_pointer]))

func previous_type() -> void:
	resources_pointer -= 1
	resources_pointer = clamp(resources_pointer, 0, RESOURCES[BODY_PARTS[body_pointer]].size() - 1)
	emit_signal("swap",BODY_PARTS[body_pointer], load(RESOURCES[BODY_PARTS[body_pointer]][resources_pointer]))


func next_body_part() -> void:
	body_pointer += 1
	resources_pointer = 0
	body_pointer = clamp(body_pointer, 0, BODY_PARTS.size() - 1)
	label.text = "Editing: " + BODY_PARTS[body_pointer]

func previous_body_part() -> void:
	body_pointer -= 1
	resources_pointer = 0
	body_pointer = clamp(body_pointer, 0, BODY_PARTS.size() - 1)
	label.text = "Editing: " + BODY_PARTS[body_pointer]

func finish_creation() -> void:
	emit_signal("created")
	queue_free()
