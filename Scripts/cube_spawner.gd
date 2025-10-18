extends Node3D

@export var timeInterval = 2.0
@export var totalCubes = 10
@export var cubeSpeed = 3
var spawnableCube = preload("res://Scenes/SpawnableCube.tscn")
@export var started = false
#@export var timerArray = [0.0, 10.2, 11.1]
var timerIndex = 0
#@export var timerArray = [2.69, 2.69, 2.69, 1.33, 1.33, 0.7, 0.7, 1.3, 2.35, 0.34, 2.7, 0.67, 0.67, 0.67, 1.06, 
#0.34, 0.94, 0.34, 0.98, 0.67, 0.65, 0.4, 0.66, 0.60, 1.01, 0.33, 0.73, 0.66, 0.85, 0.41, 0.73, 0.66, 0.66, 0.66, 0.99,
#0.59, 0.74, 0.33, 0.34, 0.73, 0.66, 0.34, 0.33, 0.67, 0.61, 0.66, 0.66, 0.66, 0.59, 0.60, 0.59, 0.14, 1.31, 0.53, 0.28,
#0.34, 0.72, 0.28, 0.34, 0.35, 0.34, 0.27, 0.39, 0.67, 0.33, 0.34, 0.65, 0.34, 0.34, 0.66, 0.66, 0.66, 0.66, 0.66, 1.31,
#1.38, 1.51, 1.25, 1.18, 1.47, 1.25, 1.38, 0.67, 0.66, 0.73, 0.66, 0.34, 0.34, 0.33, 0.33, 0.35, 0.27, 0.65, 0.67, 0.66,
#0.33, 0.34, 0.66, 0.73, 0.6, 0.4, 0.27, 0.73, 0.66, 0.59, 0.4, 0.39, 0.59, 0.67, 0.66, 0.73, 0.27, 0.40, 0.60, 0.67,
#0.33, 0.33, 0.66, 0.67, 0.66, 0.40, 0.27, 0.39, 0.34, 1.31, 1.31, 1.32, 0.26, 0.4, 0.68, 0.66, 0.73, 0.60, 0.65, 0.66,
#0.74, 0.59, 0.4, 0.33, 0.66, 0.67, 0.6, 0.73, 0.59, 0.67, 0.65, 0.35]
#DELAY IS 6 SECONDS
@export var timerArray = [2.63, 2.70, 2.57, 2.71, 1.38, 1.25, 0.67, 0.72, 1.31, 2.62, 2.70, 1.37, 1.38, 1.31,
1.32, 1.32, 1.38, 1.31, 1.31, 1.38, 2.55, 0.67, 0.73, 1.32, 1.38, 1.31, 1.38, 1.25, 1.38, 1.31, 
1.31, 0.66, 0.66, 0.66, 1.42, 0.66, 0.66, 1.42, 0.66, 0.66, 1.42, 0.66, 0.66, 0.66, 1.42]
#0.8, 0.67, 1.06, 0.48, 1.12, 0.35, 1.05, 0.4, 1.12, 0.33, 1.12, 0.33, 1.06, 0.26, 1.06, 0.34, 1.05, 0.33, 1.5]

var timerSize = timerArray.size()
func _ready() -> void:
	$Timer.wait_time = 0.11
	var timerIndex = 0

func _process(delta: float) -> void:
	pass

func _on_left_hand_button_pressed(name: String) -> void:
	if name == 'by_button':
		if started == false:
			print("Process Started")
			%Song.play()
			$Timer.start()
		print("Timer index: %d"  %timerIndex)
		print(timerArray[timerIndex])
		started = true;


func _on_timer_timeout() -> void:
	#if totalCubes > 0:
	#	totalCubes = totalCubes - 1
	if timerSize > timerIndex:
		$Timer.wait_time = timerArray[timerIndex]
		timerIndex = timerIndex + 1
		var instance = spawnableCube.instantiate()
		instance.speed = cubeSpeed
		if randf() > 0.5:
			instance.left = true
		else:
			instance.left = false
		var randDir = randf()
		if randDir > 0.75:
			instance.sliceDir = "UP"
		elif randDir > 0.5 && randDir <= 0.75:
			instance.sliceDir = "RIGHT"
		elif randDir > 0.25 && randDir <= 0.5:
			instance.sliceDir = "DOWN"
		else:
			instance.sliceDir = "LEFT"
		instance.position.x += randf_range(-0.3, 0.3)
		instance.position.y += randf_range(-0.7, 0.3)
		add_child(instance)
	else: 
		$Timer.stop()
