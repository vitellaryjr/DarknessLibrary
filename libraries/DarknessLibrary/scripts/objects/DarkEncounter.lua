local DarkEncounter, super = Class(Encounter)

function DarkEncounter:init()
    super:init(self)

    self.soul_radius = 48
end

function DarkEncounter:onBattleInit()
    self.darkness = Game.battle:addChild(DarknessOverlay())
end

function DarkEncounter:onBattleStart()
    Game.fader.alpha = 0
    Game.fader.state = "NONE"
    for _,battler in ipairs(Game.stage:getObjects(Battler)) do
        battler.light = battler:addChild(LightSource(battler.width/2, battler.height/2, 80))
        battler.light.alpha = 0
        Game.battle.timer:tween(0.5, battler.light, {alpha = 1})
    end
    self.tp_light = LightSource(15, 120, 50)
    Game.battle:addChild(self.tp_light)
end

function DarkEncounter:onStateChange(old, new)
    if new == "ACTIONSELECT" then
        if not self.ui_lights then
            self.ui_lights = {}
            for i,ui in ipairs(Game.battle.battle_ui.action_boxes) do
                ui.light = LightSource(106, 19, 120)
                ui.box:addChild(ui.light)
                if i ~= 1 then
                    ui.light.alpha = 0.5
                end
                self.ui_lights[i] = ui.light
            end
        end
    elseif new == "ENEMYDIALOGUE" then
        for _,light in ipairs(self.ui_lights) do
            light:fadeTo(0, 0.2)
        end
    elseif new == "DEFENDINGBEGIN" then
        Game.battle.soul.light = LightSource(0, 0, self.soul_radius)
        Game.battle.soul:addChild(Game.battle.soul.light)
    elseif old == "DEFENDING" then
        for i,light in ipairs(self.ui_lights) do
            if i == 1 then
                light:fadeTo(1, 0.2)
            else
                light:fadeTo(0.5, 0.1)
            end
        end
    elseif new == "VICTORY" then
        Game.battle.battle_ui:addChild(RectangleLightSource(0, 0, 640, 120, {1,1,1, 0.5}))
    end
end

function DarkEncounter:onCharacterTurn(battler, undo)
    if self.ui_lights then
        for _,light in ipairs(self.ui_lights) do
            light.alpha = 0.5
        end
        self.ui_lights[Game.battle:getPartyIndex(battler.chara.id)].alpha = 1
    end
end

return DarkEncounter