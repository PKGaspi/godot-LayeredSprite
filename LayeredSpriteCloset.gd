class_name LayeredSpriteCloset
extends Node

# LayeredSpriteCloset: A node to help iterate through Textures 
# and SpriteFrames of the layers of a LayeredSprite node.

# The path to the layered sprite itself.
export var _layered_sprite_path: NodePath
var _layered_sprite: LayeredSprite

# An array of LayerGroups. Each LayerGroup includes its group name,
# its members and their sprites.
export(Array, Resource) var _groups: Array

var group_index: int = 0 setget set_group_index
var current_group: LayerGroup
var current_group_name: String



func _ready() -> void:
	_layered_sprite = get_node(_layered_sprite_path)
	assert(_layered_sprite is LayeredSprite)
	
	set_group_index(0)


func previous_group() -> void:
	set_group_index(group_index - 1)


func previous_sprite() -> void:
	set_sprite_index(current_group.sprite_index - 1)


func next_group() -> void:
	set_group_index(group_index + 1)


func next_sprite() -> void:
	set_sprite_index(current_group.sprite_index + 1)


func set_group_index(value: int) -> void:
	group_index = int(fposmod(value, len(_groups)))
	current_group = _groups[group_index]
	current_group_name = current_group.name


func set_sprite_index(value: int) -> void:
	current_group.set_sprite_index(value)
	_apply()


func _apply() -> void:
	var sprites = current_group.get_selected_sprites()
	for sprite in sprites:
		_layered_sprite.set_sprite_layer(sprite, sprites[sprite])
