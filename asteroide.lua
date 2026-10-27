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

    activo = true,

    rutina = nil,
    recarga = 0,
    oleada = 0
}

asteroide.lista = {}

function asteroide.Crear()

    asteroide.roto = love.audio.newSource("sound/destroy.mp3", "static")
    asteroide.roto:setVolume(1)
    
    asteroide.sprite = love.graphics.newImage("img/Asteroide.png")

    asteroide.lista = {}

    asteroide.CreaUno()

    Eventos.on("asteroideDestruido",function(objetivo)  asteroide.Choque(objetivo) end)
    Eventos.on("DetenerAsteroide",function () asteroide.Detener() end)
    Eventos.on("ActivarAsteroide",function () asteroide.Continuar() end)

    asteroide.IniciarRutina()

end

function asteroide.Draw()
    
    for _, a in ipairs(asteroide.lista) do
        love.graphics.draw(a.sprite, a.x, a.y, 0, a.escala, a.escala, a.origenx, a.origeny)
    end
    
end

function asteroide.Mover(dt)
    
    if not asteroide.activo then
        return
    end

    for _, a in ipairs(asteroide.lista) do

        a.x = a.x - a.velocidad * dt

        if a.x <= -40 then
        
            a.x = 300

            a.y = math.random(10,130)

            a.velocidad = math.random(10,300)

        end 
    end
end

function asteroide.HitBox()

    if not asteroide.activo then
        return
    end

    for i, a in ipairs(asteroide.lista) do
        a.hitbox_x = a.x - a.origenx * a.escala
        a.hitbox_y = a.y - a.origeny * a.escala
    end
    
end

function asteroide.Debug()

    for i, a in ipairs(asteroide.lista) do

        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("line",a.hitbox_x,a.hitbox_y,25,20)

        love.graphics.setColor(1,1,1)
        love.graphics.circle("fill",a.hitbox_x + 12.5,a.hitbox_y + 10,1)

    end
end

function asteroide.Choque(objetivo)
     
    if not objetivo then
        return
    end

    for i, a in ipairs(asteroide.lista) do

        if a == objetivo then
            
            table.remove(asteroide.lista, i)

            love.audio.stop(asteroide.roto)
            love.audio.play(asteroide.roto)

            return
        end
    end
end

function asteroide.Detener()
    
    asteroide.activo = false

end

function asteroide.Continuar()

    asteroide.activo = true
    
end

function asteroide.IniciarRutina()

    asteroide.oleada = 1

    asteroide.rutina = coroutine.create(function ()

        while true do
            
            if asteroide.activo then
                
                    coroutine.yield(2)

                    asteroide.oleada = asteroide.oleada + 1

                    asteroide.CreaUno()

                if asteroide.oleada % 3 == 0 then

                    for _, a in ipairs(asteroide.lista) do
                        a.velocidad = a.velocidad + 50
                    end
                
                end
            end

        end
    end)
    
    local ok, espera = coroutine.resume(asteroide.rutina)

    if ok then
        
        asteroide.recarga = espera

    else

        print(espera)

    end
end

function asteroide.ActualizarRutina(dt)

    if pausa or not asteroide.activo then
        return
    end

    if not asteroide.rutina then
        return
    end
    
    asteroide.recarga = asteroide.recarga - dt

    if asteroide.recarga <= 0 then
        
        local ok, espera = coroutine.resume(asteroide.rutina)

        if ok then
            
            asteroide.recarga = espera

        else

            print(espera)
            
        end
    end
end

function asteroide.CreaUno()
    
    local nuevo = {}

    nuevo.x = 300
    nuevo.y = math.random(10,130)

    nuevo.velocidad = math.random(50,300)

    nuevo.escala = asteroide.escala
    nuevo.sprite = asteroide.sprite

    nuevo.ancho = nuevo.sprite:getWidth()
    nuevo.alto = nuevo.sprite:getHeight()

    nuevo.origenx = nuevo.ancho / 2
    nuevo.origeny = nuevo.alto / 2

    nuevo.hitbox_x = 0
    nuevo.hitbox_y = 0

    table.insert(asteroide.lista, nuevo)
end