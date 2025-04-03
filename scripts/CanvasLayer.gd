extends CanvasLayer

@onready var rotuloMoedas = $Label
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if %GameManager:
		rotuloMoedas.text = str(%GameManager.score)
	
	


func _on_button_pressed() -> void:
	get_tree().paused = true
	$Pause_menu.visible = true
	print("TESTE")
	pass # Replace with function body.
