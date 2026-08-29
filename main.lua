puntaje = 0
textPuntaje = ""
sprite = nil

centroX = 0
centroY = 0

centrospriteX = 0
centrospriteY = 0

musica = nil

sfx = nil
mejora = nil

clic = 0

escala = 0.15
escalamaxima = 0.15

fondo = nil

function love.load()

    textPuntaje = "Puntaje "

    centroX = love.graphics.getWidth()/2
    centroY = love.graphics.getHeight()/2

    sprite = love.graphics.newImage("carpincho.png")

    centrospriteX = sprite:getWidth()/2
    centrospriteY = sprite:getHeight()/2

    musica = love.audio.newSource("musica.mp3", "stream")
    musica:setLooping(true)
    musica:setVolume(0.4)
    love.audio.play(musica)

    sfx = love.audio.newSource("click.mp3", "static")
    sfx:setVolume(0.3)

    fondo = love.graphics.newImage("cherry.jpg")
end

function love.update(dt)
    
    escala = escala + (0.1 * dt)

    if escala > escalamaxima then

        escala = escalamaxima

    end
end

function love.mousepressed(x,y,boton)

    if boton == 1 then
        
        distancia = math.sqrt((x - centroX)^2 + (y - centroY)^2)

        if distancia < 190 then

            puntaje = puntaje + 1

            local nuevosonido = sfx:clone()

            clic = clic + 1

            love.audio.play(nuevosonido)

            escala = 0.12
        end
    end
end

function love.draw()

    love.graphics.draw(fondo,0,0,0,0.63,0.9,0,0)

    love.graphics.print(textPuntaje..puntaje, (centroX - 30),50)

    love.graphics.draw(sprite,centroX,centroY,0,escala,escala,centrospriteX,centrospriteY)
end