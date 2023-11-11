extends Area2D

class_name Goal
signal goal_reached

var goal_occupied : bool = false

func _on_area_entered(area):
	if goal_occupied == false:
		goal_occupied = true
		emit_signal("goal_reached")
		
