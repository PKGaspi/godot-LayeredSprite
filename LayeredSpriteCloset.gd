class_name LayeredSpriteCloset
extends Node

# LayeredSpriteCloset: A node to help iterate through Textures 
# and SpriteFrames of the layers of a LayeredSprite node.

# The path to the layered sprite itself.
export var _layered_sprite_path: NodePath
var _layered_sprite: LayeredSprite

# Key is a group name and value is an array of layer names that
# belong to that group.
export var _group_names: Dictionary
# Key is a layer name and value is an array of Texture or SpriteFrames.
export var _layer_sprites: Dictionary


var groups: Array
var current_group: String
var _group_index: int = 0 setget set_group_index



func _ready() -> void:
	_layered_sprite = get_node(_layered_sprite_path)
	assert(_layered_sprite is LayeredSprite)
	
	groups = _group_names.keys()
	set_group_index(0)



func previous_group() -> void:
	set_group_index(_group_index-1)


func next_group() -> void:
	set_group_index(_group_index+1)


func set_group_index(value: int) -> void:
	_group_index = fposmod(value, len(groups))
	current_group = groups[_group_index]


