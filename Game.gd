extends Node

@onready var layered_sprite := $LayeredSprite
@onready var closet := $LayeredSpriteCloset
@onready var group_label := $MarginContainer/HBoxContainer/Values/Group/GroupValue
@onready var sprite_label := $MarginContainer/HBoxContainer/Values/Sprite2D/SpriteValue
@onready var animations_option := $MarginContainer/HBoxContainer/Values/Animations


func _ready() -> void:
	var animations = layered_sprite.get_node("Body").sprite_frames.get_animation_names()
	var i = 0
	for animation in animations:
		animations_option.add_item(animation, i)
		i += 1
	print(layered_sprite.get_layer_position("Body"))
	print(layered_sprite.get_layer_position("Shoes"))


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit_game") or event.is_action_pressed("ui_accept"):
		exit_game()


func _physics_process(_delta: float) -> void:
	group_label.text = closet.current_group.name
	sprite_label.text = str(closet.current_group.asset_index)


func exit_game(exit_code: int = 0) -> void:
	get_tree().quit(exit_code)


func _on_Animations_item_selected(index: int) -> void:
	layered_sprite.set_animation(animations_option.get_item_text(index))
	layered_sprite.play()

func _on_CheckBox_toggled(button_pressed):
	layered_sprite.set_layer_visible("Makeup", button_pressed)
