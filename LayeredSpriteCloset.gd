class_name LayeredSpriteCloset
extends Node

# LayeredSpriteCloset: A node to help iterate through Textures 
# and SpriteFrames of the layers of a LayeredSprite node.

# The path to the layered sprite itself.
export var _layered_sprite_path: NodePath
var _layered_sprite: LayeredSprite

# Key is a group name and value is an array of layer names that
# belong to that group. If a layer is not specified in any group,
# a group for itself is created with its own name.
export var _groups: Dictionary
# Key is a layer name and value is an array of Texture or SpriteFrames.
export var _sprites: Dictionary

var _group_names: Array
var group_index: int = 0 setget set_group_index
var current_group: String



func _ready() -> void:
	_layered_sprite = get_node(_layered_sprite_path)
	assert(_layered_sprite is LayeredSprite)
	
	
	# Add all layers not included in a group to _groups.
	var layers = _layered_sprite.get_layers()
	for group in _groups:
		for group_member in _groups[group]:
			if not layers.has(group_member):
				push_warning("Layer with name '" + group_member + "' from group '" + group + "'was not found.")
			else:
				layers.erase(group_member)
	
	for layer in layers:
		_groups[layer] = layer
	
	
	_group_names = _groups.keys()
	set_group_index(0)



func previous_group() -> void:
	set_group_index(group_index-1)


func next_group() -> void:
	set_group_index(group_index+1)


func set_group_index(value: int) -> void:
	group_index = fposmod(value, len(_group_names))
	current_group = _group_names[group_index]


