class_name LayeredSpriteCloset
extends Node

# LayeredSpriteCloset: A node to help iterate through Textures 
# and SpriteFrames of the layers of a LayeredSprite node.

# The path to the layered sprite itself.
@export var _layered_sprite_path: NodePath
var layered_sprite: LayeredSprite

# An array of LayerGroups. Each LayerGroup includes 
# its group name and its members.
@export var groups: Array # (Array, Resource)

var current_group: LayerGroup
var current_group_index: int = 0: set = set_group_index



func _ready() -> void:
	layered_sprite = get_node(_layered_sprite_path)
	assert(layered_sprite is LayeredSprite)
	
	set_group_index(0)


func previous_group() -> void:
	set_group_index(current_group_index - 1)


func previous_asset() -> void:
	set_asset_index(current_group.asset_index - 1)


func next_group() -> void:
	set_group_index(current_group_index + 1)


func next_asset() -> void:
	set_asset_index(current_group.asset_index + 1)


func set_group_index(value: int) -> void:
	current_group_index = int(fposmod(value, len(groups)))
	current_group = groups[current_group_index]


func set_asset_index(value: int) -> void:
	current_group.set_asset_index(value)
	_apply()


func _apply() -> void:
	var assets = current_group.get_selected_assets()
	for asset in assets:
		layered_sprite.set_layer_asset(asset, assets[asset])
