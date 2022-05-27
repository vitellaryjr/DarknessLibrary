function Mod:init()
    Utils.hook(Map, "onEnter", function(orig, map)
        orig(map)
        local darkness = Game.world:spawnObject(DarknessOverlay(1), WORLD_LAYERS["below_ui"])
        for _,chara in ipairs(Game.stage:getObjects(Character)) do
            local light = LightSource(chara.width/2, chara.height/2, 80)
            light.alpha = 1
            chara:addChild(light)
        end

        -- local stats = "Darkness amount: "..darkness.alpha.."\n"
        -- stats = stats.."Style: "..Kristal.getLibConfig("darkness", "style").."\n"
        -- stats = stats.."Overlap: "..tostring(darkness.overlap).."\n"
        -- local text = Text(stats, 20, 20, SCREEN_WIDTH, SCREEN_HEIGHT, {style = "menu"})
        -- text:setParallax(0, 0)
        -- Game.world:spawnObject(text, WORLD_LAYERS["below_ui"])
        -- Game.world.timer:after(2, function()
        --     text:fadeOutAndRemove()
        -- end)
    end)
end