extends Panel

signal countdown_over

@onready var clock = $clock
@export var countdown_time : int = 3

func _ready():
	visible = false

func start():
	visible = true
	update_clock()
	$Timer.start()

func _on_timer_timeout():
	countdown_time -= 1
	update_clock()
	if countdown_time > 0:
		$Timer.start()
	else:
		emit_signal("countdown_over")
		countdown_time = 5
		visible = false

func update_clock():
	clock.text = str(countdown_time)

func _on_main_player_dead():
	start()


func _on_main_player_reset():
	start()
