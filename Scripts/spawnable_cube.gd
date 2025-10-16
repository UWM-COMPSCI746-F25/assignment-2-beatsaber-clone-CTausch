extends Node3D

@export var speed = 1
@export var dir = Vector3(0,0,1)
@export var left = true
@export var sliceDir = "RIGHT"
@onready var redColor = load("res://Materials/red.tres")
@onready var blueColor = load("res://Materials/blue.tres")

var initialPos
func _ready() -> void:
	$Area3D.set_collision_layer_value(1, false)
	if left == true: #moves cube to left or right
		#global_position.x += 1.0
		$Area3D.set_collision_layer_value(2, true)
		$Area3D/CSGBox3D.material = blueColor
	else:
		$Area3D.set_collision_layer_value(3, true)
		$Area3D/CSGBox3D.material = redColor
		#global_position.x -= 1.0
	
	if sliceDir == "RIGHT":
		$Sprite3D.global_rotation_degrees.z = 0.0
	if sliceDir == "UP":
		$Sprite3D.global_rotation_degrees.z = 90.0
	if sliceDir == "LEFT":
		$Sprite3D.global_rotation_degrees.z = 180.0
	if sliceDir == "DOWN":
		$Sprite3D.global_rotation_degrees.z = 270.0
	initialPos = global_position.z


func _process(delta: float) -> void:
	if global_position.z - initialPos > 25: #deletes cube after it travels a certain distance
		queue_free()


func _physics_process(delta: float) -> void:
	global_position += dir * (speed * delta)
