extends Node

## From Godot Docs
## https://docs.godotengine.org/en/stable/classes/class_input.html#enum-input-cursorshape

# Load the custom images for the mouse cursor.
var arrow = load("res://assets/sprites/cursor/hand_open.png")
var pointing = load("res://assets/sprites/cursor/hand_pointing.png")
var drag = load("res://assets/sprites/cursor/hand_closed.png")

func _ready():
	Input.set_custom_mouse_cursor(arrow)
	Input.set_custom_mouse_cursor(pointing, Input.CURSOR_POINTING_HAND)
	Input.set_custom_mouse_cursor(drag, Input.CURSOR_DRAG)
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Input.set_default_cursor_shape(Input.CURSOR_DRAG)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
