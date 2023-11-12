extends HBoxContainer

signal time_expired
signal time_left

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _on_timer_timeout():
	$ProgressBar.value -= 1
	if $ProgressBar.value <= 0:
		emit_signal("time_expired")
	$Timer.start()

func _on_main_start_game():
	await get_tree().create_timer(3).timeout
	$Timer.start()
	$ProgressBar.value = 100
	$ProgressBar.max_value = 100

func _on_tile_map_goal_filled():
	$Timer.paused = true
	await get_tree().create_timer(3).timeout
	$Timer.paused = false


func _on_tile_map_all_goals_filled():
	$Timer.paused = true
	emit_signal("time_left", $ProgressBar.value)
