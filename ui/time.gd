extends HBoxContainer

signal time_expired

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _on_timer_timeout():
	$ProgressBar.value -= 1
	if $ProgressBar.value <= 0:
		emit_signal("time_expired")
	$Timer.start()

func _on_main_start_game():
	$Timer.start()
	$ProgressBar.value = 100
	$ProgressBar.max_value = 100
