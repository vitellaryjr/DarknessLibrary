local Dummy, super = Class(Encounter)

function Dummy:init()
    super:init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* The tutorial begins...?"

    -- Battle music ("battle" is rude buster)
    self.music = "battle"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("dummy")

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
end

function Dummy:onBattleStart()
    -- add darkness
    local darkness = Game.battle:addChild(DarknessOverlay(0.5))
    -- darkness:setLayer(BATTLE_LAYERS["below_ui"]) -- make sure it's below the ui

    -- add light sources to every battler
    for _,chara in ipairs(Game.battle.party) do
        local light = LightSource(chara.width/2, chara.height/2, 80)
        light.alpha = 1
        chara:addChild(light)
    end
    for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
        local light = LightSource(enemy.width/2, enemy.height/2, 80)
        light.alpha = 1
        enemy:addChild(light)
    end
end

return Dummy