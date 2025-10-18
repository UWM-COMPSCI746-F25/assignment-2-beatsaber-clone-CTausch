extends XRController3D

@export var saberLength = 2
@export var isActive = true
@export var inCollision = false
var lastPos = Vector3.ZERO
var velocity = Vector3.ZERO


func _ready() -> void:
	lastPos = global_position
	

func _process(delta: float) -> void:
	velocity = (global_position - lastPos) / delta
	lastPos = global_position

func _physics_process(delta: float) -> void:
	
	var spaceState = get_world_3d().direct_space_state
	var origin = global_position
	var dir = global_basis.z * -1
	var end = origin + (dir * saberLength)
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	if isActive:
		query.collide_with_areas = true
		var result = spaceState.intersect_ray(query)
		if result && inCollision == false:
			handleCollision(result.collider)
		if result && result.collider.name == "Area3D":
			inCollision = true
		else:
			inCollision = false
	else:
		query.collide_with_areas = false
	#var result = spaceState.intersect_ray(query)
	#if result:
	#	print("Collision with: " + result.collider.name)
	$Saber.points[0] = origin
	if isActive:
		$Saber.points[1] = end
	else: 
		$Saber.points[1] = origin

func handleCollision(result: Object) -> void:
	#print("Collision with: " + result.collider.name)
	inCollision = true
	if result.name == 'Area3D' && name == 'LeftHand' && result.get_parent().left == true:
		if result.get_parent().sliceDir == "LEFT" && velocity.x < 0 && (velocity.abs().x > velocity.abs().y):
			result.get_parent().queue_free()
			%AudioStreamPlayer.play()
		if result.get_parent().sliceDir == "RIGHT" && velocity.x > 0 && (velocity.abs().x > velocity.abs().y):
			result.get_parent().queue_free()
			%AudioStreamPlayer.play()
		if result.get_parent().sliceDir == "UP" && velocity.y > 0 && (velocity.abs().x < velocity.abs().y):
			result.get_parent().queue_free()
			%AudioStreamPlayer.play()
		if result.get_parent().sliceDir == "DOWN" && velocity.y < 0 && (velocity.abs().x < velocity.abs().y):
			result.get_parent().queue_free()
			%AudioStreamPlayer.play()
	elif result.name == 'Area3D' && name == 'RightHand' && result.get_parent().left == false:
		if result.get_parent().sliceDir == "LEFT" && velocity.x < 0 && (velocity.abs().x > velocity.abs().y):
			result.get_parent().queue_free()
			%AudioStreamPlayer.play()
		if result.get_parent().sliceDir == "RIGHT" && velocity.x > 0 && (velocity.abs().x > velocity.abs().y):
			result.get_parent().queue_free()
			%AudioStreamPlayer.play()
		if result.get_parent().sliceDir == "UP" && velocity.y > 0 && (velocity.abs().x < velocity.abs().y):
			result.get_parent().queue_free()
			%AudioStreamPlayer.play()
		if result.get_parent().sliceDir == "DOWN" && velocity.y < 0 && (velocity.abs().x < velocity.abs().y):
			result.get_parent().queue_free()
			%AudioStreamPlayer.play()

func _on_left_hand_button_pressed(inputName: String) -> void:
	print(name)
	if inputName == 'ax_button' && name == 'LeftHand':
		print("Toggle Left")
		isActive = !isActive

func _on_right_hand_button_pressed(inputName: String) -> void:
	if inputName == 'ax' && name == 'RightHand':
		print("Toggle Right")
		isActive = !isActive


func _on_button_pressed(inputName: String) -> void:
	#if inputName == 'ax_button' && name == 'RightHand':
		#print("Toggle Right")
		#isActive = !isActive
	#elif inputName == 'ax_button' && name == 'LeftHand':
		#print("Toggle Right")
		#isActive = !isActive
	if inputName == 'ax_button':
		isActive = !isActive
		print(name)
	pass # Replace with function body.
