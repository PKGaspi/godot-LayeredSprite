# Layered Sprite
## Introduction
Layered Sprite is a Godot tool to easyly divide a sprite in layers. It can be used for customizable characters.

## Usage
For a better understanding of the tool, please consider taking a look at the [demo](https://github.com/rapsaGnauJ/godot-LayeredSprite/tree/demo).

### LayeredSprite
To use this in your scenes, add a `LayeredSprite` node. Then, as childs of that node, add `Sprite` or `AnimatedSprite` nodes. Give names to those nodes, as they will later be the layer names. You can also give those nodes their default `texture` or `SpriteFrames`.

#### Methods

- `add_animated_sprite_layer(layer_name: String, frames: SpriteFrames = null) -> void`: Creates a new `AnimatedSprite` layer.
- `add_sprite_layer(layer_name: String, texture: Texture = null) -> void`: Creates a new `Sprite` layer.
- `get_layer_count() -> int`: Returns the number of layers, that is, the number of `Sprite` and `AnimatedSprite` childs.
- `get_layer_position(layer_name: String) -> int`: Returns the position (or depth) of the layer. Layers with lower position draw first, behind layers with higher position.
- `get_layers() -> Dictionary`: Returns a Dictionary of every layer, where the Keys are the layer names and the Values a reference to the layer node.
- `has_layer(layer_name: String) -> bool`: Returns whether or not such layer exists.
- `is_animated_sprite_layer(layer_name: String) -> bool`: Returns whether or not such layer is an `AnimatedSprite` layer.
- `is_sprite_layer(layer_name: String) -> bool`: Returns whether or not such layer is a `Sprite` layer.
- `move_layer(layer_name: String, to_position: int) -> void`: Moves a layer to the given position. It uses Godot's `move_child` in the background.
- `remove_layer(layer_name: String) -> void`: Removes a layer.
- `set_animation(animation: String) -> void`: Sets an animation to all `AnimatedSprite` layers.
- `set_layer_animation(layer_name: String, animation: String) -> void`: Sets an animation to a specific `AnimatedSprite` layer.
- `set_layer_asset(layer_name: String, asset) -> void`: Sets the asset of a layer, that is, its `texture` or `SpriteFrames`.
- `set_layer_visible(layer_name: String, value: bool) -> void`: Sets the `visible` property of a layer. Please, don't directly modify the `visible` parameter of layers.

### LayeredSpriteCloset

To manage different layer assets you can use a `LayeredSpriteCloset` node. This node can handle groups of layers and lists of assets for each group. To organize this, you'll have to create different `LayerGroup` resources. Each group has a name and one or more members. Each member is a Dictionary entry, where the Key is the layer name and the value is an array of the different assets (`texture` or `SpriteFrames`).

#### Properties

- `layered_sprite`: The `LayeredSprite` node to change.
- `groups`: Array of `LayerGroups`.
- `current_group`: The currently selected group.
- `current_group_index`: The index of the currently selected group.

#### Methods

- `previous_group() -> void`: Selects the previous group.
- `previous_asset() -> void`: Selects the previous asset of the current group·
- `next_group() -> void`: Selects the next group.
- `next_asset() -> void`: Selects the next asset of the current group·
- `set_group_index(value: int) -> void`: Selects a group given it's index.
- `set_asset_index(value: int) -> void`: Selects an asset of the current group given it's index.
