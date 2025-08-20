extends CharacterBody2D

@export_category("Variables")
@export var SPEED : float = 64.0
# Called when the node enters the scene tree for the first time.
@export var anim_tree : AnimationTree = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
var state_machine

func _ready() -> void:
	state_machine = anim_tree["parameters/playback"]

func _process(delta: float) -> void:
	move_behaviour(delta)
	animate()
	move_and_slide()

func move_behaviour(delta: float) -> void:
	var direction : Vector2 = Vector2(
		Input.get_axis("ui_left","ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)
	
	if direction:
		velocity = direction * SPEED
		anim_tree["parameters/walk/blend_position"] = direction
	else:
		velocity = Vector2.ZERO
		anim_tree["parameters/idle/blend_position"] = direction
	
func animate()-> void:
	
	if velocity != Vector2.ZERO:
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")
	
