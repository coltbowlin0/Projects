-- Resolution setup
local WW, WH = love.window.getDesktopDimensions()
WW, WH = WW * 0.8, WH * 0.8
local VW, VH = 500, 500

-- Animation variables
local logo_sheet, logo_quad
local frameWidth, frameHeight = 240, 240
local currentFrame = 1
local totalFrames =  170.00001
local animTimer = 0
local frameDuration = 0.033

function love.load()
    push = require 'libs/push'
    love.graphics.setDefaultFilter("nearest", "nearest")
    push:setupScreen(VW, VH, WW, WH, {vsync = 1, resizable = true, fullscreen = false, fullscreentype = "desktop"})
    
    local success, result = pcall(love.graphics.newImage, 'vids/Logo_Sheet_240x240.png')
    
    if success and result then
        logo_sheet = result
        logo_state = "Playing"
        logo_quad = love.graphics.newQuad(0, 0, frameWidth, frameHeight, logo_sheet:getDimensions())
    else
        logo_sheet = nil
        logo_state = "Ready"
        print("Logo sheet failed to load: skipping to Ready.")
    end

    if logo_state == "Ready" then

    end
end

function love.resize(w, h)
    push:resize(w, h)
end

local columns = 14

function love.update(dt)
    if logo_state == "Playing" and logo_sheet then
        animTimer = animTimer + dt
        if animTimer >= frameDuration then
            animTimer = 0
            currentFrame = currentFrame + 1
            
            if currentFrame <= totalFrames then
                local col = (currentFrame - 1) % columns
                local row = math.floor((currentFrame - 1) / columns)
                
                local x = col * frameWidth
                local y = row * frameHeight
                
                logo_quad:setViewport(x, y, frameWidth, frameHeight)
            else
                logo_state = "Ready"
            end
        end
    end
end

function love.draw()
    push:start()
        if logo_state == "Playing" and logo_sheet then
            love.graphics.draw(logo_sheet, logo_quad, 130, 130)
        elseif logo_state == "Ready" then
            
        end
    push:finish()
end