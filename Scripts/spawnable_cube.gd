extends Node3D

@export var speed = 1
@export var dir = Vector3(0,0,1)
@export var left = true
var initialPos
func _ready() -> void:
	if left == true: #moves cube to left or right
		global_position.x += 1.0
	else:
		global_position.x -= 1.0
	initialPos = global_position.z


func _process(delta: float) -> void:
	if global_position.z - initialPos > 25: #deletes cube after it travels a certain distance
		queue_free()


func _physics_process(delta: float) -> void:
	global_position += dir * (speed * delta)
