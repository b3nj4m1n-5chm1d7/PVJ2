asteroide = {

    x = 300,
    y = 0,

    sprite = nil,

    alto = 0,
    ancho = 0,

    escala = 0.15,

    velocidad = 0,

    hitbox_x = 0,
    hitbox_y = 0,

    origenx = 0,
    origeny = 0,

    choca = false,

    roto = nil,

    activo = true

}

function asteroide.Crear()

    asteroide.roto = love.audio.newSource("sound/destroy.mp3", "static")
    asteroide.roto:setVolume(1)
    
    asteroide.sprite = love.graphics.newImage("img/Asteroide.png")

    asteroide.velocidad = math.random(50,300)

    asteroide.y = math.random(10,130)

    asteroide.ancho = asteroide.sprite:getWidth()
    asteroide.alto = asteroide.sprite:getHeight()

    asteroide.origenx = asteroide.ancho
    asteroide.origeny = asteroide.alto

    Eventos.on("asteroideDestruido",function()  asteroide.Choque() end)
    Eventos.on("DetenerAsteroide",function () asteroide.Detener() end)
    Eventos.on("ActivarAsteroide",function () asteroide.Continuar() end)

end

function asteroide.Draw()
    
    love.graphics.draw(asteroide.sprite, asteroide.x, asteroide.y, 0, asteroide.escala, asteroide.escala, asteroide.origenx, asteroide.origeny)

end

function asteroide.Mover(dt)
    
    if not asteroide.activo then
        return
    end

    asteroide.x = asteroide.x - asteroide.velocidad * dt

    if asteroide.x <= -40 then
        
        asteroide.x = 300

        asteroide.y = math.random(10,130)

        asteroide.velocidad = math.random(10,300)

    end
end

function asteroide.HitBox()

    asteroide.hitbox_x = asteroide.x - 25
    asteroide.hitbox_y = asteroide.y - 21
    
end

function asteroide.Debug()
    
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("line",asteroide.hitbox_x,asteroide.hitbox_y,25,20)

    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill",asteroide.hitbox_x + 12.5,asteroide.hitbox_y + 10,1)

end

function asteroide.Choque()
     
        asteroide.x = 350
        asteroide.y = math.random(10,130)
        asteroide.velocidad = math.random(50,300)
        love.audio.play(asteroide.roto)

end

function asteroide.Detener()
    
    asteroide.activo = false

end

function asteroide.Continuar()

    asteroide.activo = true
    
end