local Lib = {}

function Lib:init()
    -- if an encounter will be dark, fade to black early so it transitions smoothly
    Utils.hook(ChaserEnemy, "onCollide", function(orig, enemy, player)
        orig(enemy, player)
        if enemy.encountered then
            local encounter = enemy.encounter
            if type(encounter) == "string" then
                encounter = Registry.getEncounter(encounter)
            end
            if encounter and isClass(encounter) and encounter:includes(DarkEncounter) then
                if not enemy.dark_fading then
                    enemy.dark_fading = true
                    Game.fader:fadeOut(nil, {speed = 0.2})
                end
            end
        end
    end)
end

return Lib