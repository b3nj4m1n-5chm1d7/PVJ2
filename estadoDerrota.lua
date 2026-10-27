EstadoDerrota = Class{_includes = Estado}

fondo2 = nil

function EstadoDerrota:draw()

    love.graphics.draw(fondo2,0,0,0,2,1.5)

    love.graphics.setFont(fuente2)
    love.graphics.setColor(1,0,0)
    love.graphics.printf("Perdiste", 0, 64, ventana.ancho * ventana.escala, 'center')
    love.graphics.setColor(0,0,1)
    love.graphics.printf("reiniciar", 0,260,ventana.ancho * ventana.escala, 'center')
    love.graphics.setColor(1,1,1)
    love.graphics.printf("presione Esc", 0, 480, ventana.ancho * ventana.escala, 'center')

end

function EstadoDerrota:init()

    fondo2 = love.graphics.newImage("img/Blackhole.png")
    
end

function EstadoDerrota:actualizar()
    
end

function EstadoDerrota:ingresar()
    
end

function EstadoDerrota:salir()
    
end