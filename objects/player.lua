local Player = Object:extend()

NewImage("player")

local move_damp = 0.2
local speed = 1.3

function Player:new()
    Game.player = self
    
    self.x = 0
    self.y = 0
    self.w = Image.player:getWidth()
    self.h = Image.player:getHeight()
    
    self.mx = 0
    self.my = 0
    
    if not Edit.editing then
        Camera:offset(Res.w/2, Res.h/2)
        Camera:set(self.x+self.w/2, self.y+self.h/2)
        Camera:snap_back()
    end
    
    Game:add(OBJECTS.spinner)
end

function Player:update(dt)
    Camera:set(self.x+self.w/2, self.y+self.h/2)

    local ix = 0
    if Input.right.down then
        ix = ix+1
    end
    if Input.left.down then
        ix = ix-1
    end
    local iy = 0
    if Input.down.down then
        iy = iy+1
    end
    if Input.up.down then
        iy = iy-1
    end

    self.mx = self.mx+(ix*speed-self.mx)*move_damp*dt
    self.my = self.my+(iy*speed-self.my)*move_damp*dt

    self.x = self.x+self.mx*dt
    self.y = self.y+self.my*dt
end

function Player:draw()
    love.graphics.draw(Image.player, self.x, self.y)
end

return Player