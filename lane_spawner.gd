extends Marker2D

class_name LaneSpawner

@export_range(0,10) var lane_number : int = 0
@export var lane_speed : int
@export var spawn_time_min : int = 3
@export var spawn_time_max : int = 6
@export var spawns : Array[PackedScene] 
var random_speed : int 

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func start(current_level):
	spawn_lane()
	random_speed = randi_range(lane_speed-10, lane_speed+10) + current_level * 2

func spawn_lane():
	var spawn = spawns[randi() % spawns.size()]
	var new_spawn = spawn.instantiate()
	
	var pos = global_position
	var dir = get_lane_dir()
	var speed = random_speed
	add_child(new_spawn)
	new_spawn.start(pos, dir, speed)
	$SpawnTimer.wait_time = randi_range(spawn_time_min, spawn_time_max)
	$SpawnTimer.start()
	
func get_lane_dir():
	if global_position.x < 0:
		return Vector2(1,0)
	else:
		return Vector2(-1,0)

func _on_spawn_timer_timeout():
	$SpawnTimer.wait_time = randi_range(spawn_time_min, spawn_time_max)
	$SpawnTimer.start()
	spawn_lane()

func clear_lane():
	for child in get_children():
		call_deferred("queue_free", child)
