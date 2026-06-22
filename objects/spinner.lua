local Spinner = Object:extend()

local size = 6
local dist = TILE_SIZE*1.5
local speed_mult = 0.2
local speed_damp = 0.01
local speed_boost = 1.5
local base_spin_speed = 3
local spin_dist = 1.5

local filters = {
    enemy = {"enemy"}
}

function Spinner:new()
    self.x = Game.player.x+Game.player.w/2+dist
    self.y = Game.player.y+Game.player.h/2
    self.w = 0
    self.h = 0
    self.mx = 0
    self.my = 0

    self.spin_speed = base_spin_speed
    self.spin = 0

    self.cbs = {
        enemy = function (other)
            other:die()
            self.spin_speed = self.spin_speed+speed_boost
        end,
    }
end

function Spinner:update(dt)
    local x = math.cos(math.rad(self.spin))
    local y = math.sin(math.rad(self.spin))
    self.x = Game.player.x+Game.player.w/2+x*(dist+self.spin_speed*spin_dist)
    self.y = Game.player.y+Game.player.h/2+y*(dist+self.spin_speed*spin_dist)

    self.spin_speed = self.spin_speed+math.sign(y)*Game.player.mx*speed_mult*dt
    self.spin_speed = self.spin_speed-math.sign(x)*Game.player.my*speed_mult*dt
    self.spin_speed = self.spin_speed+(base_spin_speed-self.spin_speed)*speed_damp*dt
    self.spin_speed = math.max(self.spin_speed, base_spin_speed)
    self.spin = self.spin+self.spin_speed*dt

    Physics.dist(self, filters.enemy, self.cbs.enemy, size*3)
end

function Spinner:draw()
    love.graphics.circle("fill", self.x, self.y, size)
end

return Spinner