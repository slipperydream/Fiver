extends Node2D

signal game_over
signal player_dead
signal won_game
signal life_earned
signal start_game
signal player_reset
signal score_changed
signal level_clear

@onready var lane_0 = $CanvasLayer/LaneSpawner0
@onready var lane_1 = $CanvasLayer/LaneSpawner1
@onready var lane_2 = $CanvasLayer/LaneSpawner2
@onready var lane_3 = $CanvasLayer/LaneSpawner3
@onready var lane_4 = $CanvasLayer/LaneSpawner4
@onready var lane_5 = $CanvasLayer/LaneSpawner5
@onready var lane_6 = $CanvasLayer/LaneSpawner6
@onready var lane_7 = $CanvasLayer/LaneSpawner7
@onready var lane_8 = $CanvasLayer/LaneSpawner8
@onready var lane_9 = $CanvasLayer/LaneSpawner9
@onready var lane_10 = $CanvasLayer/LaneSpawner10

@export var max_level : int = 10
var max_lives : int = 10
var start_lives : int = 3
var lives : int = 0
@onready var player = $CanvasLayer/Player
@onready var title_screen = $CanvasLayer/TitleScreen
@onready var current_level : int = 0

var score : int = 0
@export var forward_move_score : int = 10
@export var goal_reached_score : int = 50
@export var score_per_second_remaining : int = 20
@export var all_goals_reached_score : int = 1000

var new_life_min
@export var bonus_interval : int = 20000

# Called when the node enters the scene tree for the first time.
func _ready():
	fill_lanes()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func clear_lanes():
	lane_0.clear_lane()
	lane_1.clear_lane()
	lane_2.clear_lane()
	lane_3.clear_lane()
	lane_4.clear_lane()
	if current_level >= max_level/2:
		lane_5.clear_lane()
	lane_6.clear_lane()
	lane_7.clear_lane()
	lane_8.clear_lane()
	lane_9.clear_lane()
	lane_10.clear_lane()
	
func fill_lanes():
	randomize()
	lane_0.start(current_level)
	lane_1.start(current_level)
	lane_2.start(current_level)
	lane_3.start(current_level)
	lane_4.start(current_level)
	if current_level >= max_level/2:
		lane_5.start(current_level)
	lane_6.start(current_level)
	lane_7.start(current_level)
	lane_8.start(current_level)
	lane_9.start(current_level)
	lane_10.start(current_level)

func _on_player_died():
	lives -= 1
	if lives <= 0:
		emit_signal("game_over")
	else:
		emit_signal("player_dead")

func _on_countdown_panel_countdown_over():
	player.reset()

func _on_game_over():
	player.enabled = true
	await get_tree().create_timer(1).timeout
	HighScoreSystem.check_for_high_score(score)
	await get_tree().create_timer(2).timeout
	title_screen.visible = true

func _on_time_time_expired():
	emit_signal("game_over")

func update_score(value):
	score += value
	emit_signal("score_changed", score)
	if score >= new_life_min:
		new_life_min += bonus_interval
		emit_signal("life_earned")

func _on_player_moved_forward():
	update_score(forward_move_score)

func _on_life_earned():
	lives += 1
	lives = min(lives, max_lives)

func _on_start_game():
	lives = start_lives
	emit_signal("player_reset")
	score = 0
	new_life_min = bonus_interval

func _on_tile_map_all_goals_filled():
	update_score(all_goals_reached_score)
	clear_lanes()
	emit_signal("level_clear")

func _on_tile_map_goal_filled():
	update_score(goal_reached_score)
	emit_signal("player_reset")

func _on_title_screen_new_game():
	emit_signal("start_game")

func _on_time_time_left(value):
	update_score(value * score_per_second_remaining)

func _on_level_clear():
	fill_lanes()
	emit_signal("player_reset")
	
