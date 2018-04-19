bird = {
    posX = 50,
    posY = 100,
    speedX = 0,
    speedY = 0,
    img = love.graphics.newImage('frame-1.png')
}

flapping = false

function love.load()
end

function love.update(dt)
    bird.speedY = bird.speedY + 1200 * dt
    bird.posY = bird.posY + bird.speedY * dt

    if love.keyboard.isDown('up', 'w') and flapping ~= true then
        bird.speedY = -600
        flapping = true
    end

    if not love.keyboard.isDown('up', 'w') and flapping == true then
        flapping = false
    end
end

function love.draw(dt)
    love.graphics.clear(100, 200, 255)

    love.graphics.draw(bird.img, bird.posX, bird.posY)
end