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
    obsticles = {}

end
timer = 0
function obsticle_S()
    obsticle = {
    color = 2.52, 2.11, 3,
    w = 50,
    h = 1000,
    gapY = VH / 2,
    mode = "fill"
    }
    if timer >= 0.99 then
        table.insert(obsticles, obsticle)
    end
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
    if logo_state == "Ready" then
        timer = timer + dt
        if timer >= 1 then
            timer = 0
        end
    end
end

function love.draw()
    push:start()
        if logo_state == "Playing" then
            love.graphics.draw(logo, 0, 0)
        elseif logo_state == "Ready" then
            for obsticle in ipairs(obsticles) do
                love.grahpics.color = obsticle.color
                love.graphics.rectangle(obsticle.mode, obsticle.x, obsticle.y, obsticle.width, obsticle.height)
            end
        end
    push:finish()
end