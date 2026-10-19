Disparo = {

    x = 0,
    y = 0,

    sprite = nil,

    audio = nil,

    origenx = 0,

    activo = false,

    laser = nil,

    escala = 0.15,

    hitbox_x = 0,
    hitbox_y = 0,

    alto = 0,
    ancho = 0
}

function Disparo.Carga()
    
    Disparo.laser = love.audio.newSource("sound/Laser.mp3", "static")
    Disparo.laser:setVolume(0.2)

    Disparo.sprite = love.graphics.newImage("img/Laser.png")

    Disparo.alto = Disparo.sprite:getHeight()
    Disparo.ancho = Disparo.sprite:getWidth()

    Disparo.x = nave.x
    Disparo.y = nave.y - 40

    Disparo.origenx = Disparo.x

    Disparo.activo = false

    Eventos.on("reinicio",function()
        Disparo.x = nave.x
        Disparo.y = nave.y - 40
        end)

end

function Disparo.Mover(dt)

    if Disparo.activo then
        Disparo.x = Disparo.x + (300 * dt)

        if Disparo.x > 250 then
            Disparo.x = Disparo.origenx
            Disparo.activo = false
        end
    end

end

function Disparo.Draw()
    
    if Disparo.activo then

        love.graphics.draw(Disparo.sprite, Disparo.x, Disparo.y,0,Disparo.escala,Disparo.escala)

    end

end

function Disparo.HitBox()
    
    Disparo.hitbox_x = Disparo.x + 5
    Disparo.hitbox_y = Disparo.y + 3

end

function Disparo.Debug()
    
    love.graphics.setColor(0, 0, 1)
    love.graphics.rectangle("line",Disparo.hitbox_x,Disparo.hitbox_y,25,5)

    love.graphics.setColor(1,0,1)
    love.graphics.circle("fill",Disparo.hitbox_x + 12.5,Disparo.hitbox_y + 2,1)

end