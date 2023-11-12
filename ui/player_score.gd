extends VBoxContainer

var starting_score : String = "00000000"
# Called when the node enters the scene tree for the first time.
func _ready():
	update_score(starting_score)

func _on_main_score_changed(value):
	update_score(value)
	
func update_score(value):
	$Score.text = str(value)
