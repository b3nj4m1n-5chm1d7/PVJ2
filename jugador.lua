jugador = {
    x = 0,
    y = 0,
    sprite = nil,
    escala = 0.13,
    origenx = 0,
    origeny = 0,
    ancho = 0,
    altura = 0,
    velocidad = 50,

    hitbox_x = 0,
    hitbox_y = 0
}

function jugador.Crear()

    jugador.sprite = love.graphics.newImage("pato.png")

    --Calculo Alto y Ancho
    jugador.ancho = jugador.sprite:getWidth()
    jugador.altura = jugador.sprite:getHeight()

    --Calculo Origenes
    jugador.origenx = jugador.ancho/2
    jugador.origeny = jugador.altura/2

    --Centrado
    jugador.x = ventana.ancho/2
    jugador.y = ventana.alto/2

end

function jugador.Mover(dt)

     if love.keyboard.isDown("right") then
        jugador.x = jugador.x + (jugador.velocidad * dt)
    elseif love.keyboard.isDown("left") then
        jugador.x = jugador.x - (jugador.velocidad * dt)
    elseif love.keyboard.isDown("up") then
        jugador.y = jugador.y - (jugador.velocidad * dt)
    elseif love.keyboard.isDown("down") then
        jugador.y = jugador.y + (jugador.velocidad * dt)
    end

end

function jugador.HitBox()

    jugador.hitbox_x = jugador.x - (jugador.origenx)/6.5

    jugador.hitbox_y = jugador.y - (jugador.origeny)/8

end

function jugador.Draw()

    love.graphics.draw(jugador.sprite,jugador.x,jugador.y,0,jugador.escala,jugador.escala,jugador.origenx,jugador.origeny)

end

function jugador.Debug()
    
    love.graphics.setColor(0, 0, 1)
    love.graphics.rectangle("line",jugador.hitbox_x,jugador.hitbox_y,25,30)

    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill",jugador.x,jugador.y,1)

end