extends Label

func _ready():
	visible = false
	
func _on_main_won_game():
	visible = true
	text = "You win!"
	add_theme_color_override("font_color", Color.SNOW)


func _on_main_game_over():
	visible = true
	text = "Game Over"
	add_theme_color_override("font_color", Color.CRIMSON)
