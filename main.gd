extends Node2D

signal game_over
signal player_dead

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


@export var max_level : int = 5
@export var max_lives : int = 3
var lives : int = 0
@onready var player = $CanvasLayer/Player
@onready var current_level : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	fill_lanes()
	lives = max_lives
	player.reset()

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
