extends Control

signal new_game

func _on_play_game_button_pressed():
	emit_signal("new_game")


func _on_exit_game_button_pressed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)


func _on_main_start_game():
	visible = false
