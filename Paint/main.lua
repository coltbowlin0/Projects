local WW, WH = love.window.getDesktopDimensions()
local WW, WH = WW * 0.8, WH * 0.8
local VW, VH = 500, 500

function love.load()
    push = require 'libs/push'
    love.graphics.setDefaultFilter("nearest", "nearest")
    push:setupScreen(VW, VH, WW, WH, {vsync = 1, resizable = true, fullscreen = false, fullscreentype = "desktop"})
   -- local success, result = pcall(love.graphics.newVideo, 'vids/Logo-
    if success and result then
        logo = result
        logo_state = "Playing"
        logo:play()
    else
        logo = nil
        logo_state = "Ready"
        print("Video load failed: skipping to Ready state.")
    end */

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    if logo then
        if logo:isPlaying() then
            logo_state = "Playing"
        else
            logo_state = "Ready"
        end
    end
end

function love.draw()
    push:start()
        if logo_state == "Playing" and logo then
            love.graphics.draw(logo, 0, 0)
        elseif logo_state == "Ready" then
            love.graphics.print("Press Start or Game Content Here", 10, 10)
        end
    push:finish()
end