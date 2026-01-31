local WW, WH = love.window.getDesktopDimensions()
local WW, WH = WW * 0.8, WH * 0.8
local VW, VH = 500, 500
function love.load()
    push = require 'libs/push'
    love.graphics.setDefaultFilter("nearest", "nearest")
    push:setupScreen(VW, VH, WW, WH, {vsync = 1, resizable = true, fullscreen = false, fullscreentype = "desktop"})
    logo = love.graphics.newVideo('vids/Logo-Animation.ogv')
    logo_state = "Playing"
    logo:play()
    
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    if logo:isPlaying() then
        logo_state = "Playing"
    elseif not logo:isPlaying() then
        logo_state = "Ready"
    end
end

function love.draw()
    push:start()
        if logo_state == "Playing" then
            love.graphics.draw(logo, 0, 0)
        elseif logo_state == "Ready" then
        end
    push:finish()
end