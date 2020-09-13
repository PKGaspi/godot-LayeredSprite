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
var current_group: String



func _ready() -> void:
	_layered_sprite = get_node(_layered_sprite_path)
	assert(_layered_sprite is LayeredSprite)
	
	set_group_index(0)



func previous_group() -> void:
	set_group_index(group_index-1)


func next_group() -> void:
	set_group_index(group_index+1)


func set_group_index(value: int) -> void:
	group_index = fposmod(value, len(_groups))
	current_group = _groups[group_index].name


