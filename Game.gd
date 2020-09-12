extends Node

onready var layered_sprite := $LayeredSprite

func _ready() -> void:
	var layers = layered_sprite.get_layers()
	print(layered_sprite.get_layer_count())
	for layer in layers:
		printt(layer, layers[layer], layered_sprite.get_layer_position(layer))
	
	layered_sprite.remove_layer("Makeup")
	print(layered_sprite.get_layer_count())
	
	print(layered_sprite.get_layers())
	
	layered_sprite.set_animation("dance")
	layered_sprite.set_layer_animation("Body", "dance")
	layered_sprite.set_layer_animation("Hat", "dance")
	layered_sprite.remove_layer("Hat")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit_game") or event.is_action_pressed("ui_accept"):
		exit_game()


func exit_game(exit_code: int = 0) -> void:
	get_tree().quit(exit_code)
