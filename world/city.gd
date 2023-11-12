extends TileMap

signal goal_filled
signal all_goals_filled

var goals_filled : int = 0
var total_goals : int = 4
# Called when the node enters the scene tree for the first time.
func _ready():
	goals_filled = 0

func _on_goal_goal_reached():
	goal_filled.emit()
	goals_filled += 1
	if goals_filled >= total_goals:
		all_goals_filled.emit()

func _on_goal_2_goal_reached():
	goal_filled.emit()
	goals_filled += 1
	if goals_filled >= total_goals:
		all_goals_filled.emit()

func _on_goal_3_goal_reached():
	goal_filled.emit()
	goals_filled += 1
	if goals_filled >= total_goals:
		all_goals_filled.emit()

func _on_goal_4_goal_reached():
	goal_filled.emit()
	goals_filled += 1
	if goals_filled >= total_goals:
		all_goals_filled.emit()

func _on_main_level_clear():
	for child in get_children():
		if child is Goal:
			child.reset()
