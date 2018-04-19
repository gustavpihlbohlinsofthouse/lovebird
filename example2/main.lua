bird = {
    x = 50,
    y = 100,
    img = love.graphics.newImage('frame-1.png')
}

function love.load()
end

function love.update(dt)
    bird.y = bird.y + 1
end

function love.draw(dt)
    love.graphics.clear(100, 200, 255)

    love.graphics.draw(bird.img, bird.x, bird.y)
end