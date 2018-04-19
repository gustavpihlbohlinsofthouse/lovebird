birdImg = love.graphics.newImage('frame-1.png')

function love.load()
end

function love.update(dt)
end

function love.draw(dt)
    love.graphics.clear(100, 200, 255)

    love.graphics.draw(birdImg, 50, 100)
end