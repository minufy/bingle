local EnemySpawner = Object:extend()

local spawn_delay = 100

local function pos(i)
    if i == 1 then
        return {math.random(-10, 10)*0.1, 1}
    end
    if i == 2 then
        return {math.random(-10, 10)*0.1, -1}
    end
    if i == 3 then
        return {1, math.random(-10, 10)*0.1}
    end
    if i == 4 then
        return {-1, math.random(-10, 10)*0.1}
    end
end

function EnemySpawner:new()
    self.spawn_timer = Timer(spawn_delay)
end

function EnemySpawner:update(dt)
    if self.spawn_timer:run(dt) then
        local i = math.random(1, 4)
        local sign_x, sign_y = unpack(pos(i))
        Game:add(OBJECTS.enemy, Game.player.x+Res.w*0.6*sign_x, Game.player.y+Res.h*0.6*sign_y)
    end
end

return EnemySpawner