local Enemy = Object:extend()

NewImage("enemy")

local min_move_speed = 5
local max_move_speed = 10

function Enemy:new(x, y)
    self.x = x
    self.y = y
    self.w = Image.enemy:getWidth()
    self.h = Image.enemy:getHeight()

    self.mx = 0
    self.my = 0
    self.speed = math.random(min_move_speed, max_move_speed)*0.1
end

function Enemy:update(dt)
    local angle = math.atan2(Game.player.y-self.y, Game.player.x-self.x)
    self.mx = math.cos(angle)*self.speed
    self.my = math.sin(angle)*self.speed

    self.x = self.x+self.mx*dt
    self.y = self.y+self.my*dt
end

function Enemy:draw()
    love.graphics.draw(Image.enemy, self.x, self.y+SinEffect()*2)
end

function Enemy:die()
    self.remove = true
    for _ = 1, 4 do
        Game:add(Particle, self.x+self.w/2, self.y+self.h/2, math.random(-20, 20), math.random(-20, 20), math.random(5, 10))
    end
    Camera:shake(4)
end

return Enemy