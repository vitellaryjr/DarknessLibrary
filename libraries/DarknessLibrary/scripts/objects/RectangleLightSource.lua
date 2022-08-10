local Light, super = Class(Object)

function Light:init(x, y, w, h, color, alpha)
    super:init(self, x, y, w, h)
    self.color = color or {1,1,1}
    self.alpha = alpha or self.color[4] or 1
    self.inherit_color = false
    self.style = Kristal.getLibConfig("darkness", "style")
    -- don't allow debug selecting
    self.debug_select = false
end

return Light