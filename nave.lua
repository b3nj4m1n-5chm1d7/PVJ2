nave = {

    x = 0,
    y = 0,

    velocidad = 60,

    sprite = nil,
    alto = 0,
    ancho = 0,

    origenx = 0,
    origeny = 0,

    escala = 0.15,

    hitbox_x = 0,
    hitbox_y = 0,

    activo = true,

    color = {1,1,1,1}

}

function nave.Crear()

    nave.sprite = love.graphics.newImage("img/Nave.png")

    nave.alto = nave.sprite:getHeight()
    nave.ancho = nave.sprite:getWidth()

    nave.x = 50
    nave.y = 100

    nave.origenx = nave.ancho
    nave.origeny = nave.alto

    Eventos.on("DetenerNave",function() nave.Detener() end)
    Eventos.on("ActivarNave",function () nave.Continuar() end)

end

function nave.Mover(dt)
    
    if not nave.activo then
        return
    end
    
    if love.keyboard.isDown("up") then

        nave.y = nave.y - (nave.velocidad * dt)

    elseif love.keyboard.isDown("down") then

        nave.y = nave.y + (nave.velocidad * dt)

    end

end

function nave.HitBox()

    nave.hitbox_x = nave.x - 55
    nave.hitbox_y = nave.y - 46.5
    
end

function nave.Draw()

    love.graphics.setColor(nave.color)
    love.graphics.draw(nave.sprite, nave.x, nave.y, 0, nave.escala, nave.escala, nave.origenx, nave.origeny)
    love.graphics.setColor(1,1,1)
end

function nave.Debug()

    love.graphics.setColor(0, 0, 1)
    love.graphics.rectangle("line",nave.hitbox_x,nave.hitbox_y,55,25)

    love.graphics.setColor(1,0,1)
    love.graphics.circle("fill",nave.hitbox_x + 20,nave.hitbox_y + 12,1)

end

function nave.Detener()
    
    nave.activo = false

end

function nave.Continuar()
    
    nave.activo = true

end