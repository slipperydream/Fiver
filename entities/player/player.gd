extends Area2D

class_name Player
signal died
signal moved_forward

@export var start_pos : Vector2 = Vector2(350, 880)
@onready var sprites = $AnimatedSprite2D
var speed : int = 64
var velocity : Vector2 = Vector2.ZERO
var dead : bool = false
var enabled : bool = false
var tween

# Called when the node enters the scene tree for the first time.
func _ready():
	sprites.play("idle")
	set_emitters(false)
	dead = true
	enabled = true

func get_input():
	if Input.is_action_just_pressed("left"):
		sprites.play("left")
		hop(Vector2.LEFT)
	elif Input.is_action_just_pressed("right"):
		sprites.play("right")
		hop(Vector2.RIGHT)
	elif Input.is_action_just_pressed("up"):
		sprites.play("forward")
		hop(Vector2.UP)
		emit_signal("moved_forward")
	elif Input.is_action_just_pressed("down"):
		sprites.play("back")
		hop(Vector2.DOWN)
	

func _process(delta):
	if dead:
		return
	if enabled == false:
		return
	if tween == null or tween.is_running() == false:
		get_input()
	
	var new_pos = position + velocity * delta 
	position = new_pos

func hop(dir):
	
	var new_pos = position + dir * speed
	tween = create_tween()
	tween.tween_property(self, "position", new_pos, 1/speed)
	
	
func _on_visible_on_screen_enabler_2d_screen_exited():
	die()

func _on_area_entered(area):
	if dead:
		return
	if area is Vehicle:
		splat()
	elif area is Crocodile:
		eaten()
	elif area is Floater:
		velocity = area.direction * area.speed
	elif area is Barrier:
		print("barrier")
		velocity = Vector2.ZERO
		bonk()
	elif area is Water:
		pass
		#drown()
	elif area is Goal:
		if area.goal_occupied:
			position.y += speed/2
		else:
			area.goal_occupied = true
			enabled = false

func splat():
	sprites.play("splat")
	set_emitters(true)
	die()

func eaten():
	$AnimationPlayer.play("eaten")
	die()

func drown():
	die()
	
func bonk():
	$AnimationPlayer.play("bonk")
	position.y += speed/2
	
func set_emitters(value):
	for child in get_children():
		if child is GPUParticles2D:
			child.emitting = value

func die():
	emit_signal("died")
	dead = true

func reset():
	enabled = true
	dead = false
	sprites.visible = true
	sprites.position = Vector2.ZERO
	sprites.scale = Vector2(1,1)
	sprites.flip_v = false
	position = start_pos
	velocity = Vector2.ZERO
	sprites.play("idle")

func _on_area_exited(area):
	velocity = Vector2.ZERO

func _on_main_game_over():
	dead = true

