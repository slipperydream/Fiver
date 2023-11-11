extends Area2D

class_name Crocodile

@onready var sprites = $AnimatedSprite2D

var speed : int = 0
var speed_backup : int = 0
var direction : Vector2 = Vector2(1,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	if sprites:
		sprites.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta
	
func start(pos, dir, spd):
	global_position = pos
	direction = dir
	speed = spd
	speed_backup = spd
	if direction.x == -1:
		sprites.flip_h = true

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area is Player:
		speed_backup = speed
		speed = 0
		sprites.play("attack")
		
func _on_animated_sprite_2d_animation_finished():
	sprites.play("idle")
	speed = speed_backup
