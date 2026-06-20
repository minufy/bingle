local Bullet = Object:extend()
SetType(Bullet, "bullet")

local size = 4
local time = 240
local speed = 6

function Bullet:new(x, y, mx, my)
    self.x = x
    self.y = y
    self.mx = mx
    self.my = my
    self.time = time
end

function Bullet:update(dt)
    self.x = self.x+self.mx*speed*dt
    self.y = self.y+self.my*speed*dt
    self.time = self.time-dt
    if self.time <= 0 then
        self.remove = true
    end
end

function Bullet:draw()
    love.graphics.circle("fill", self.x, self.y, size)
end

return Bullet