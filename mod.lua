function Mod:init()
    Utils.hook(Map, "onEnter", function(orig, map)
        orig(map)
        Game.world:spawnObject(DarknessOverlay(1), WORLD_LAYERS["below_ui"])
        for _,chara in ipairs(Game.stage:getObjects(Character)) do
            local light = LightSource(chara.width/2, chara.height/2, 80)
            light.alpha = 1
            chara:addChild(light)
        end
    end)
end