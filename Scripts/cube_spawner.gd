extends Node3D

@export var timeInterval = 2.0
@export var totalCubes = 10
@export var cubeSpeed = 3
@onready var spawnableCube = load("res://Scenes/SpawnableCube.tscn")
func _ready() -> void:
	$Timer.wait_time = timeInterval

func _process(delta: float) -> void:
	pass

func _on_left_hand_button_pressed(name: String) -> void:
	if name == 'ax_button':
		print("Process Started")
		$Timer.start()
		


func _on_timer_timeout() -> void:
	if totalCubes > 0:
		totalCubes = totalCubes - 1
		var instance = spawnableCube.instantiate()
		instance.speed = cubeSpeed
		if randf() > 0.5:
			instance.left = true
		else:
			instance.left = false
		add_child(instance)
	else: 
		$Timer.stop()
