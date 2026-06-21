WINDOW_W = 300
WINDOW_H = 200
CONSOLE = true

function love.conf(t)
    t.window.resizable = true
    t.console = CONSOLE
    t.window.width = WINDOW_W*3
    t.window.height = WINDOW_H*3
end