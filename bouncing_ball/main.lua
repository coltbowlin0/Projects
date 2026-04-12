-- Resolution setup
local WW, WH = love.window.getDesktopDimensions()
WW, WH = WW * 0.8, WH * 0.8
local VW, VH = WW, WH

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
    ball = {
        x = VW / 2;
        y = VH / 2;
        radius = 50;
        speedx = 100;
        speedy = 100;
        color = 1;
        COLOR = {1, 1, 1}
    }
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
    elseif logo_state == "Ready" then
        ball.x = ball.x + ball.speedx * dt
        ball.y = ball.y + ball.speedy * dt

        if ball.x + ball.radius >= VW then
            ball.speedx = -ball.speedx
            ball.color = ball.color + 1
        elseif ball.x - ball.radius <= 0 then
            ball.speedx = -ball.speedx
            ball.color = ball.color + 1
        end

        if ball.y + ball.radius >= VH then
            ball.speedy = -ball.speedy
            ball.color = ball.color + 1
        elseif ball.y - ball.radius <= 0 then
            ball.speedy = -ball.speedy
            ball.color = ball.color + 1
        end

        if ball.color > 3 then
            ball.color = 1
        end
        if ball.color == 1 then
            ball.COLOR = {1, 0, 0}
        elseif ball.color == 2 then
            ball.COLOR = {1, 1, 1}
        elseif ball.color == 3 then 
            ball.COLOR = {0, 0, 1}
        end
    end
end

function love.draw()
    push:start()
        if logo_state == "Playing" and logo_sheet then
            love.graphics.draw(logo_sheet, logo_quad, VW / 2, VH / 2, 0, 2, 2, frameWidth / 2, frameHeight / 2)
        elseif logo_state == "Ready" then
            love.graphics.setColor(ball.COLOR)
            love.graphics.circle("fill", ball.x, ball.y, ball.radius)
        end
    push:finish()
end