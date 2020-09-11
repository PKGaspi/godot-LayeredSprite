extends Node


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit_game") or event.is_action_pressed("ui_accept"):
		exit_game()


func exit_game(exit_code: int = 0) -> void:
	get_tree().quit(exit_code)
