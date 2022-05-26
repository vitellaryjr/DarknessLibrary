local Darkness, super = Class(Object)

function Darkness:init(alpha, color)
    super:init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    -- above everything, including ui, by default
    -- if you want it to be below ui, set its layer
    self.layer = 1000

    -- parallax set to 0 so it's always aligned with the camera
    self:setParallax(0, 0)

    self.alpha = alpha or 1
    self.style = Kristal.getLibConfig("darkness", "style")
end

function Darkness:draw()
    local canvas = Draw.pushCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setColor(1-self.alpha, 1-self.alpha, 1-self.alpha)
    love.graphics.rectangle("fill",0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
    love.graphics.setBlendMode("add")
    for _,light in ipairs(Game.stage:getObjects(LightSource)) do
        local x, y = light:getRelativePosition(0,0, self)
        local color = Utils.copy(light.color)
        local alpha = color[4] or light.alpha
        local radius = light:getRadius()

        if self.style = "solid" then
            love.graphics.setColor(Utils.lerp({0,0,0}, color, alpha))
            love.graphics.circle("fill", x, y, radius)
        elseif self.style = "soft" then
            love.graphics.setColor(Utils.lerp({0,0,0}, color, alpha/2))
            love.graphics.circle("fill", x, y, radius)
            love.graphics.setColor(Utils.lerp({0,0,0}, color, alpha))
            love.graphics.circle("fill", x, y, radius*0.75)
        end
    end
    love.graphics.setBlendMode("alpha")
    Draw.popCanvas()

    love.graphics.setBlendMode("multiply", "premultiplied")
    love.graphics.setColor(1,1,1)
    love.graphics.draw(canvas)
    love.graphics.setBlendMode("alpha")
end

return Darkness