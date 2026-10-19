EstadoTitulo = Class {_includes = Estado}

background = nil

function EstadoTitulo:init()

    self.titulo = "Prototipo N 3"
    self.subtitulo = "Benjamin Schmidt"

    background = love.graphics.newImage("img/Nebulosa.jpeg")

    preludio = love.audio.newSource("sound/Inicio.mp3", "stream")
    preludio:setLooping(true)
    preludio:setVolume(0.5)

    love.audio.play(preludio)
end

function EstadoTitulo:draw()
    
    love.graphics.draw(background, 0, 0, 0, 2.75)
    love.graphics.setFont(fuente1)
    love.graphics.setColor(0,1,0)
    love.graphics.printf(self.titulo, 0, 64, ventana.ancho * ventana.escala, 'center')
    love.graphics.setColor(0,1,1)
    love.graphics.printf(self.subtitulo, 0, 200, ventana.ancho * ventana.escala, 'center')
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(fuente4)
    love.graphics.printf("Enter para iniciar", 0, 550, ventana.ancho * ventana.escala, 'center')

end

function EstadoTitulo:actualizar(dt) end

function EstadoTitulo:ingresar() end

function EstadoTitulo:salir() end