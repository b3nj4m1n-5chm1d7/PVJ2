EstadoDerrota = Class{_includes = Estado}

function EstadoDerrota:draw()

    love.graphics.setFont(fuente2)
    love.graphics.setColor(1,0,0)
    love.graphics.printf("Perdiste", 0, 64, ventana.ancho * ventana.escala, 'center')
    love.graphics.setColor(0,0,1)
    love.graphics.printf("reiniciar", 0,260,ventana.ancho * ventana.escala, 'center')
    love.graphics.setColor(1,1,1)

end

function EstadoDerrota:init()
    
end

function EstadoDerrota:actualizar()
    
end

function EstadoDerrota:ingresar()
    
end

function EstadoDerrota:salir()
    
end