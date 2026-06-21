Input.jump = NewInput({"space", "up", "w"})

-- Audio:add("jump")

Camera.x_damp = 0.1
Camera.y_damp = 0.1
Camera.shake_damp = 0.3

TILE_TYPES = {
    -- "tile",
}
OBJECT_TYPES = {
    "player",
    "bullet",
    "enemy",
    "enemy_spawner",
}
IMG_TYPES = {
    -- "test",
}

TILE_SIZE = 16
GRID_SIZE = TILE_SIZE/2

local object_align = {
    player = Align.Bottom,
}
OBJECT_ALIGN = setmetatable(object_align, {
    __index = function (t, k)
        return Align.None
    end
})