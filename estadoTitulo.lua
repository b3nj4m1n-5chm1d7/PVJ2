EstadoTitulo = Class {_includes = Estado}

function EstadoTitulo:init()
    self.titulo = "Prototipo Nº2"
    self.subtitulo = "Benjamin Schmidt"
end

function EstadoTitulo:draw()
    
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