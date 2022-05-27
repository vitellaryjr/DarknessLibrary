local Darkness, super = Class(Event)

function Darkness:init(data)
    super:init(self, data)
    self.darkness = Game.world:spawnObject(DarknessOverlay(data.properties["alpha"] or 1), WORLD_LAYERS["below_ui"])
end

function Darkness:postLoad()
    local characters = {}
    if self.data.properties["characters"] then
        if self.data.properties["characters"] == "all" then
            characters = Game.stage:getObjects(Character)
        else
            for _,chara in ipairs(Game.stage:getObjects(Character)) do
                if self.data.properties["characters"]:find(chara.actor.id) then
                    table.insert(characters, chara)
                end
            end
        end
    end
    if self.data.properties["player_light"] then
        if not Utils.containsValue(characters, Game.world.player) then
            table.insert(characters, Game.world.player)
        end
    end

    local radius = self.data.properties["radius"] or 80
    for _,chara in ipairs(characters) do
        local light = LightSource(chara.width/2, chara.height/2, radius)
        light.alpha = self.data.properties["alpha"] or 1
        chara:addChild(light)
    end
end

return Darkness