extends VBoxContainer

var starting_score : String = "00000000"
# Called when the node enters the scene tree for the first time.
func _ready():
	$Score.text = starting_score
