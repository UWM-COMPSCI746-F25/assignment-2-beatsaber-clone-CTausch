extends XRController3D

@export var saberLength = 2
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
	query.collide_with_areas = true
	var result = spaceState.intersect_ray(query)
	if result:
		print("Collision with: " + result.collider.name)
	$Saber.points[0] = origin
	$Saber.points[1] = end
