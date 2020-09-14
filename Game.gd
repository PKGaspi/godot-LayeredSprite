extends Node

onready var layered_sprite := $LayeredSprite
onready var closet := $LayeredSpriteCloset
onready var group_label := $MarginContainer/HBoxContainer/Values/Group/GroupValue
onready var sprite_label := $MarginContainer/HBoxContainer/Values/Sprite/SpriteValue




func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit_game") or event.is_action_pressed("ui_accept"):
		exit_game()


func _physics_process(delta: float) -> void:
	group_label.text = closet.current_group_name
	sprite_label.text = str(closet.current_group.sprite_index)


func exit_game(exit_code: int = 0) -> void:
	get_tree().quit(exit_code)
