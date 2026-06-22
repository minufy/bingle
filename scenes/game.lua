Game = {}
local GameBase = require("stuff.game_base")
GameBase(Game)

NewImage("bg")

function Game:init()
    -- Edit:init()
    Level:init()
    self.objects = {}
    self:add(OBJECTS.player)
    self:add(OBJECTS.enemy_spawner)
end

function Game:update(dt)
    -- Edit:update(dt)
    Camera:update(dt)

    if not Edit.editing then
        self.group_names = {}
        for group_name, _ in pairs(self.objects) do
            table.insert(self.group_names, group_name)
        end
        for _, group_name in ipairs(self.group_names) do
            local i = #self.objects[group_name]
            while i > 0 do
                local object = self.objects[group_name][i]
                if object.update then
                    object:update(dt)
                end
                if object.remove then
                    self.objects[group_name][i] = self.objects[group_name][#self.objects[group_name]]
                    self.objects[group_name][#self.objects[group_name]] = nil
                end
                i = i-1
            end
        end
    end
end

function Game:draw_bg()
    local size = TILE_SIZE*2
    love.graphics.setColor(0, 0, 0, 0.05)
    local ox = math.round(self.player.x, size)
    local oy = math.round(self.player.y, size)
    for x = -1, Res.w/size+1 do
        for y = -1, Res.h/size+1 do
            if (x+ox+y+oy)%2 == 0 then
                love.graphics.rectangle("fill", (x+ox)*size-Res.w/2, (y+oy)*size-Res.h/2, size, size)
            end
        end
    end
    Color.reset()
end

function Game:draw()
    love.graphics.draw(Image.bg)
    Camera:start()
    self:draw_bg()
    Camera:stop()
    
    for group_name, group in pairs(self.objects) do
        Camera:start()
        Outline:start()
        for _, object in ipairs(group) do
            if object.draw then
                object:draw()
            end
        end
        Camera:stop()
        Outline:stop()
    end
    
    -- Camera:start()
    -- if Edit.editing then
    --     Edit:draw()
    -- end
    -- Camera:stop()

    -- if Edit.editing then
    --     Edit:draw_hud()
    -- end
end

return Game