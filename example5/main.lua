drawCollisionBoxes = true

birdImages = {
    love.graphics.newImage('frame-1.png'),
    love.graphics.newImage('frame-2.png'),
    love.graphics.newImage('frame-dead.png'),
}

Bird = {}
Bird.new = function(posX, posY)
    local self = {}
    self.posX = posX
    self.posY = posY
    self.speedX = 0
    self.speedY = 0
    self.img = birdImages[1]
    self.angle = 1
    self.flapping = false
    self.alive = true

    self.collisionRectX = 20
    self.collisionRectWidth = self.img:getWidth() - 40
    self.collisionRectY = 20
    self.collisionRectHeight = self.img:getHeight() - 60
    return self
end

bird = Bird.new(100, 100)

Pipe = {}
Pipe.new = function(posX, posY)
    local self = {}
    self.posX = posX
    self.posY = posY
    self.img = love.graphics.newImage('pipeGreen.png')

    self.collisionRectX = 0
    self.collisionRectWidth = self.img:getWidth()
    self.collisionRectY = 0
    self.collisionRectHeight = self.img:getHeight()
    return self
end

pipe = Pipe.new(800, 390)

function love.load()
end

function love.update(dt)
    dt = dt * 0.5

    if bird.alive then
        bird.speedY = bird.speedY + 1200 * dt
        bird.posY = bird.posY + bird.speedY * dt
        bird.angle = bird.speedY / 1200
    
        pipe.posX = pipe.posX - 200 * dt
    
        if love.keyboard.isDown('up', 'w') and bird.flapping ~= true then
            bird.speedY = math.max(bird.speedY - 800, -800)
            bird.flapping = true
            bird.img = birdImages[2]
        end
    
        if not love.keyboard.isDown('up', 'w') and bird.flapping == true then
            bird.flapping = false
            bird.img = birdImages[1]
        end

        if bird.posX + bird.collisionRectX < pipe.posX + pipe.collisionRectX + pipe.collisionRectWidth and bird.posX + bird.collisionRectX + bird.collisionRectWidth > pipe.posX + pipe.collisionRectX and bird.posY + bird.collisionRectY < pipe.posY + pipe.collisionRectY + pipe.collisionRectHeight and bird.posY + bird.collisionRectHeight + bird.collisionRectY > pipe.posY + pipe.collisionRectY then
            bird.alive = false
        end

    else
        bird.img = birdImages[3]
    end
end

function love.draw(dt)
    love.graphics.clear(100, 200, 240)

    love.graphics.draw(pipe.img, pipe.posX, pipe.posY)

    love.graphics.draw(bird.img, bird.posX + bird.img:getWidth()/2, bird.posY + bird.img:getHeight()/2, bird.angle, 1, 1, bird.img:getWidth()/2, bird.img:getHeight()/2)

    if drawCollisionBoxes == true then
        love.graphics.setColor(255,0,0)
        love.graphics.rectangle("line", bird.posX + bird.collisionRectX, bird.posY + bird.collisionRectY, bird.collisionRectWidth, bird.collisionRectHeight)

        love.graphics.rectangle("line", pipe.posX + pipe.collisionRectX, pipe.posY + pipe.collisionRectY, pipe.collisionRectWidth, pipe.collisionRectHeight)        
        love.graphics.setColor(255,255,255)
    end
end