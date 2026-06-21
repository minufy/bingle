local Player = Object:extend()

NewImage("player")

local spin_speed = 4
local spin_dist = TILE_SIZE*1.2
local move_damp = 0.2
local move_force = 5

function Player:new()
    Game.player = self

    self.x = 0
    self.y = 0
    self.w = Image.player:getWidth()
    self.h = Image.player:getHeight()

    self.mx = 0
    self.my = 0
    self.spin = 0
    self.spin_speed = 0

    if not Edit.editing then
        Camera:offset(Res.w/2, Res.h/2)
        Camera:set(self.x+self.w/2, self.y+self.h/2)
        Camera:snap_back()
    end
end

function Player:update(dt)
    Camera:set(self.x+self.w/2, self.y+self.h/2)
    self.spin = self.spin+self.spin_speed*dt
    
    if Input.jump.pressed then
        Camera:shake(1)
    end
    if Input.jump.released then
        local x = math.cos(math.rad(self.spin))
        local y = math.sin(math.rad(self.spin))
        self.mx = -x*move_force
        self.my = -y*move_force
        Camera:shake(2)
        for _ = 1, 4 do
            Game:add(Particle, self.x+self.w/2+x*spin_dist, self.y+self.h/2+y*spin_dist, -x*15+math.random(-12, 12), -y*15+math.random(-12, 12), math.random(4, 8))
        end
        Game:add(OBJECTS.bullet, self.x+self.w/2, self.y+self.h/2, x, y)
    end

    if Input.jump.down then
        self.spin_speed = 0
    else
        self.spin_speed = spin_speed
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
    love.graphics.circle("fill", self.x+self.w/2+x*spin_dist, self.y+self.h/2+y*spin_dist, 3)
end

return Player