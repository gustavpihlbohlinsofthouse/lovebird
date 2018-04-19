birdImages = {
    love.graphics.newImage('frame-1.png'),
    love.graphics.newImage('frame-2.png')
}

bird = {
    posX = 100,
    posY = 100,
    speedX = 0,
    speedY = 0,
    img = birdImages[1],
    angle = 1,
    flapping = false
}

function love.load()
end

function love.update(dt)
    bird.speedY = bird.speedY + 1200 * dt
    bird.posY = bird.posY + bird.speedY * dt

    bird.angle = bird.speedY / 1200

    if love.keyboard.isDown('up', 'w') and bird.flapping ~= true then
        bird.speedY = math.max(bird.speedY - 800, -800)
        bird.flapping = true
        bird.img = birdImages[2]
    end

    if not love.keyboard.isDown('up', 'w') and bird.flapping == true then
        bird.flapping = false
        bird.img = birdImages[1]
    end
end

function love.draw(dt)
    love.graphics.clear(100, 200, 255)

    love.graphics.draw(bird.img, bird.posX, bird.posY, bird.angle, 1, 1, bird.img:getWidth()/2, bird.img:getHeight()/2)
end