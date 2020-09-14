class_name LayerGroup
extends Resource


export var name: String
export var members: Dictionary

var n_sprites: int

var sprite_index: int = 0


func previous_sprite() -> void:
	set_sprite_index(sprite_index - 1)


func next_sprite() -> void:
	set_sprite_index(sprite_index + 1)


func set_sprite_index(value: int) -> void:
	var n_sprites := len(members[members.keys()[0]])
	sprite_index = fposmod(value, n_sprites)


# Returns a dictionary of the selected sprite (Texture or SpriteFrames)
# of every member of this group, where Key is the member (layer) name and
# value is the sprite itself.
func get_selected_sprites() -> Dictionary:
	var sprites: Dictionary
	for member in members:
		sprites[member] = members[member][sprite_index]
	return sprites
