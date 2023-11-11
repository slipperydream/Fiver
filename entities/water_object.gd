extends Area2D

class_name Floater

@onready var sprite = $Sprite2D
var speed : int = 0
var direction : Vector2 = Vector2(1,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	if $AnimationPlayer:
		$AnimationPlayer.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta
	
func start(pos, dir, spd):
	global_position = pos
	direction = dir
	speed = spd
	if direction.x == -1:
		sprite.flip_h = true

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
