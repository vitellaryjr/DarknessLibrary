# Darkness Library by vitellary

A dynamic lighting library, allowing mod makers to add darkness to rooms or battles and customize light sources! This library adds several objects and events that can be used for this.

The following is a list of objects that have been added for this library:

`DarknessOverlay`: This object will create darkness over the screen. It takes an alpha argument, which will define the alpha value of the darkness, defaulting to 1. Should be added to game state objects, such as Game.world or Game.battle.  
`LightSource`: LightSources are used to make objects emit circles of light around them. They can be added to any object. They take the arguments x, y, and radius, defining the center of the light relative to its parent, and the radius of the circle in pixels. radius can also be a function that returns a number, which can be used to make a radius value that changes over time.  
`RectangleLightSource`: Similar to LightSource, but in a rectangular shape. Takes the arguments x, y, width, and height, defining the position of the rectangle's topleft, and its size in pixels.  

There is also a lightsource event, which can be placed in the overworld to create LightSources. If the event shape is a point or a circle, the event will create a LightSource, and if the shape is a rectangle, it will create a RectangleLightSource. The following properties can be defined for the lightsource event (with parantheses describing what type of value a property should be):
* `color` (`color`): Defines the color of the light source. Defaults to white.
* `alpha` (`float`): Defines the alpha of the light source. Should be a number between 0 and 1. Defaults to 1. Will override the alpha defined by color if defined.
* `radius` (`int`): If the event shape is a point, this value will be used to define the radius of the light source, and is unused otherwise. Defaults to 40.
* `style` (`string`): Overrides the default style for the light source if defined. Can be either "solid" or "soft". See the description of config values below for more detail.
* `extend` (`int`): If the light source's style is soft (either through the mod's config option or by defining style), then this will override how far the light extends outwards.

Additionally, this library adds `darkness` and `attachedlight` controllers to allow defining more lighting for the overworld.

The `darkness` controller adds a DarknessOverlay to the map, and can automatically add light sources to characters. The following properties can be defined for it:
* `alpha` (`float`): Defines the alpha of the darkness. Should be a number between 0 and 1. Defaults to 1.
* `characters` (`string`): A list of character IDs that should have light sources attached to them (eg. "kris,susie,ralsei"). Alternatively, if this string is "all", then light sources will be attached to every character in the room (including NPCs and enemies), and if this string is "party", then light sources will be attached to all party members.
* `light_radius` (`int`): Defines the radius that light sources spawned by the controller should have. Defaults to 80 (equal to 2 tiles).
* `light_color` (`color`): Defines the color that light sources spawned by the controller should have. Defaults to white.
* `light_alpha` (`float`): Defines the alpha that light sources spawned by the controller should have. Should be a value between 0 and 1. Defaults to 1.

The `attachedlight` controller allows the modder to add a LightSource to any event in a map. The light source will be positioned at the object's middle by default. The following properties can be defined for it:
* `target` OR `target1`, `target2`, ... (`object`): The object(s) that a LightSource should be added to.
* `radius` (`int`): Defines the radius that light sources spawned by the controller should have. Defaults to 80 (equal to 2 tiles).
* `color` (`color`): Defines the color that light sources spawned by the controller should have. Defaults to white.
* `alpha` (`float`): Defines the alpha that light sources spawned by the controller should have. Should be a value between 0 and 1. Defaults to 1.
* `offset_x`, `offset_y` (`int`): Offset's the light's position by the specified values, if defined.

Finally, the library has a few config options that can be defined for it. The library's ID is `darkness`, and the following is a list of options that can be defined:
* `style`: Defines the style that light sources will have by default. Can be either `"solid"` or `"soft"`. The "solid" style makes light sources use their alpha directly with no embellishment, while the "soft" style automatically adds a more transparent second light source around other light sources. Defaults to solid.
* `overlap`: Whether overlapping light sources with less than 1 alpha should add together to create a brighter region, or whether they should not overlap and only use the value of the brighter light source. Defaults to false.