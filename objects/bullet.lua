local Bullet = Object:extend()

local size = 4
local time = 240
local speed = 6

local filters = {
    enemy = {"enemy"}
}

function Bullet:new(x, y, mx, my)
    self.x = x
    self.y = y
    self.w = 0
    self.h = 0
    self.mx = mx
    self.my = my
    self.time = time

    self.cbs = {
        enemy = function (other)
            other:die()
        end,
    }
end

function Bullet:update(dt)
    self.x = self.x+self.mx*speed*dt
    self.y = self.y+self.my*speed*dt

    Physics.dist(self, filters.enemy, self.cbs.enemy, size*3)

    self.time = self.time-dt
    if self.time <= 0 then
        self.remove = true
    end
end

function Bullet:draw()
    love.graphics.circle("fill", self.x, self.y, size)
end

return Bullet