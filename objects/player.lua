local Player = Object:extend()

local Bullet = require("objects.bullet")

NewImage("player")

local spin_speed = 4
local spin_dist = TILE_SIZE*1.5
local spin_speed_damp = 0.05
local max_move_force = 20
local move_damp = 0.2

function Player:new(data)
    self.x = data.x
    self.y = data.y
    self.w = Image.player:getWidth()
    self.h = Image.player:getHeight()

    self.mx = 0
    self.my = 0
    self.spin = 0
    self.spin_speed = 0
    self.spin_dir = 1
    self.move_force = 0

    if not Edit.editing then
        Camera:offset(Res.w/2, Res.h/2)
        Camera:set(self.x+self.w/2, self.y+self.h/2)
        Camera:snap_back()
    end
end

function Player:update(dt)
    Camera:set(self.x+self.w/2, self.y+self.h/2)
    self.spin = self.spin+self.spin_speed*self.spin_dir*dt
    
    if Input.jump.released then
        local x = math.cos(math.rad(self.spin))
        local y = math.sin(math.rad(self.spin))
        self.mx = -x*self.move_force
        self.my = -y*self.move_force
        Camera:shake(self.move_force*0.4)
        for i = 1, 4 do
            Game:add(Particle, self.x+self.w/2+x*spin_dist, self.y+self.h/2+y*spin_dist, -x*15+math.random(-12, 12), -y*15+math.random(-12, 12), math.random(4, 8))
        end
        Game:add(Bullet, self.x+self.w/2, self.y+self.h/2, x, y)
        self.spin_dir = -self.spin_dir
    end

    if Input.jump.down then
        self.spin_speed = self.spin_speed-self.spin_speed*spin_speed_damp*dt
        self.move_force = self.move_force+(max_move_force-self.move_force)*spin_speed_damp*dt
    else
        self.spin_speed = spin_speed
        self.move_force = 2
    end

    self.mx = self.mx-self.mx*move_damp*dt
    self.my = self.my-self.my*move_damp*dt

    self.x = self.x+self.mx*dt
    self.y = self.y+self.my*dt
end

function Player:draw()
    love.graphics.draw(Image.player, self.x, self.y)
    local x = math.cos(math.rad(self.spin))
    local y = math.sin(math.rad(self.spin))
    love.graphics.circle("fill", self.x+self.w/2+x*spin_dist, self.y+self.h/2+y*spin_dist, math.log(self.move_force)*2)
end

return Player