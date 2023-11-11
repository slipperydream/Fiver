extends Node2D

signal game_over
signal player_dead
signal won_game
signal life_earned
signal start_game
signal player_reset

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
	emit_signal("start_game")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fill_lanes():
	lane_0.start()
	lane_1.start()
	lane_2.start()
	lane_3.start()
	lane_4.start()
	if current_level >= max_level/2:
		lane_5.start()
	lane_6.start()
	lane_7.start()
	lane_8.start()
	lane_9.start()
	lane_10.start()

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

func _on_time_time_expired():
	emit_signal("game_over")

func update_score(value):
	score += value
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
	player.reset()
	score = 0
	new_life_min = bonus_interval

func _on_tile_map_all_goals_filled():
	update_score(all_goals_reached_score)
	emit_signal("player_reset")

func _on_tile_map_goal_filled():
	update_score(goal_reached_score)
	emit_signal("player_reset")

