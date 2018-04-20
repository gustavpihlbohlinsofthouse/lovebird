drawCollisionBoxes = true

birdImages = {
    love.graphics.newImage('frame-1.png'),
    love.graphics.newImage('frame-2.png'),
    love.graphics.newImage('frame-dead.png'),
}

--Bird class!
Bird = {}
Bird.__index = Bird --Lua class syntax is a bit different from other languages
Bird.new = function(posX, posY)
    local self = {}
    setmetatable(self, Bird)

    --member variables
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

    function self:die()
        self.alive = false
        bird.img = birdImages[3]
    end

    function self:update(dt)
    
        self.speedY = self.speedY + 1200 * dt
        self.posY = self.posY + self.speedY * dt
        self.angle = self.speedY / 1200
    
        if love.keyboard.isDown('up', 'w') and self.flapping ~= true then
            self.speedY = math.max(bird.speedY - 800, -800)
            self.flapping = true
            self.img = birdImages[2]
        end
    
        if not love.keyboard.isDown('up', 'w') and bird.flapping == true then
            self.flapping = false
            self.img = birdImages[1]
        end
    end

    function self:checkCollision(pipe)
        --collision check, AABB vs AABB
        if self.posX + self.collisionRectX < pipe.posX + pipe.collisionRectX + pipe.collisionRectWidth
        and self.posX + self.collisionRectX + self.collisionRectWidth > pipe.posX + pipe.collisionRectX
        and self.posY + self.collisionRectY < pipe.posY + pipe.collisionRectY + pipe.collisionRectHeight
        and self.posY + self.collisionRectHeight + self.collisionRectY > pipe.posY + pipe.collisionRectY then
            self:die()
        end
    end

    return self
end

bird = Bird.new(100, 100)

Pipe = {}
Pipe.__index = Pipe
Pipe.new = function(posX, posY)
    local self = {}
    setmetatable(self, Pipe)

    self.posX = posX
    self.posY = posY
    self.img = love.graphics.newImage('pipeGreen.png')

    self.collisionRectX = 0
    self.collisionRectWidth = self.img:getWidth()
    self.collisionRectY = 0
    self.collisionRectHeight = self.img:getHeight()

    function self:update(dt)
        self.posX = self.posX - 200 * dt
    end

    return self
end

pipe = Pipe.new(800, 390)

function love.load()
end

function love.update(dt)
    dt = dt * 1

    if bird.alive then
        bird:update(dt)
        pipe:update(dt)
    end

    bird:checkCollision(pipe)

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