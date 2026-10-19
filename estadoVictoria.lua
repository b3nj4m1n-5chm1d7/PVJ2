EstadoVictoria = Class {_includes = Estado}

fonda = nil

function EstadoVictoria:draw()

    love.graphics.draw(fonda, 0, 0, 0, 0.5)

    love.graphics.printf("VICTORIA",0,200,ventana.ancho * ventana.escala, 'center')
    love.graphics.printf("Iniciar nuevamente",0, 550,ventana.ancho * ventana.escala, 'center')

end

function EstadoVictoria:init()

    fonda = love.graphics.newImage("img/Nova.jpg")
    
end

function EstadoVictoria:actualizar()

end

function EstadoVictoria:ingresar()
    
end

function EstadoVictoria:salir()
    
end