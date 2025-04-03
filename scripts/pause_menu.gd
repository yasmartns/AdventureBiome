extends CanvasLayer

@onready var pause_btn = $menu_holder/Pause_btn

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = !visible
		get_tree().paused = !get_tree().paused
		


func _on_pause_btn_pressed():
	get_tree().paused = false
	visible = false


func _on_quit_btn_2_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
