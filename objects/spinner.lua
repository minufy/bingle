local Spinner = Object:extend()

local length = TILE_SIZE*2
local size = 4
local k = 0.6
local damp = 0
local mass = 2

local filters = {
    enemy = {"enemy"}
}

function Spinner:new()
    self.x = Game.player.x+Game.player.w/2+length
    self.y = Game.player.y+Game.player.h/2
    self.w = 0
    self.h = 0
    self.mx = 0
    self.my = 0

    self.spin_speed = 0
    self.spin = 0

    self.cbs = {
        enemy = function (other)
            other:die()
        end,
    }
end

function Spinner:update(dt)
    local target_x = Game.player.x+Game.player.w/2
    local target_y = Game.player.y+Game.player.h/2
    local delta = {x = target_x-self.x, y = target_y-self.y}
    local dist = math.sqrt(delta.x^2+delta.y^2)
    local dir = {x = 0, y = 0}
    if dist > 0 then
        dir = {x = delta.x/dist, y = delta.y/dist}
    end
    local stretch = dist-length
    local spring_force = k*stretch
    local rel_vel = {x = Game.player.mx-self.mx, y = Game.player.my-self.my}
    local damp_force = damp*(rel_vel.x*dir.x+rel_vel.y*dir.y)
    local force = {x = dir.x*(spring_force+damp_force), y = dir.y*(spring_force+damp_force)}
    self.mx = force.x/mass*dt
    self.my = force.y/mass*dt
    self.x = self.x+self.mx*dt
    self.y = self.y+self.my*dt
    -- local x = math.cos(math.rad(self.spin))
    -- local y = math.sin(math.rad(self.spin))
    -- local target_x = Game.player.x+Game.player.w/2+x*dist
    -- local target_y = Game.player.y+Game.player.h/2+y*dist
    
    -- local mx = target_x-self.x
    -- local my = target_y-self.y

    -- self.spin_speed = my
    -- Log(self.spin_speed)
    -- self.spin = self.spin+self.spin_speed*dt

    -- self.x = target_x
    -- self.y = target_y
    
    Physics.dist(self, filters.enemy, self.cbs.enemy, size*3)
end

function Spinner:draw()
    love.graphics.circle("fill", self.x, self.y, size)
end

return Spinner