class_name LayerGroup
extends Resource


export var name: String
export var members: Dictionary


var asset_index: int = 0


func previous_asset() -> void:
	set_asset_index(asset_index - 1)


func next_asset() -> void:
	set_asset_index(asset_index + 1)


func set_asset_index(value: int) -> void:
	var n_assets := len(members[members.keys()[0]])
	asset_index = int(fposmod(value, n_assets))


# Returns a dictionary of the selected asset (Texture or SpriteFrames)
# of every member of this group, where Key is the member (layer) name and
# value is the asset itself.
func get_selected_assets() -> Dictionary:
	var assets: Dictionary = {}
	for member in members:
		assets[member] = members[member][asset_index]
	return assets
