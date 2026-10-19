EstadoControls = Class{_includes = Estado}

fondo3 = nil

function EstadoControls:draw()

    love.graphics.draw(fondo3,0,0,0,2)

    love.graphics.setColor(1,1,0)

    love.graphics.print("Controles:",500,150)

    love.graphics.print("Flechas up/down: mover la nave",360,200)
    love.graphics.print("Espacio: Disparar",450,250)

    love.graphics.setColor(0,1,0)
    love.graphics.print("Objetivo: esquivar y destruir los asteroides",250,500)

    love.graphics.setColor(1,1,1)
    love.graphics.print("activar/reiniciar juego : O",380,650)
    
end

function EstadoControls:init()

    fondo3 = love.graphics.newImage("img/Aster.png")
    
end

function EstadoControls:actualizar()
    
end

function EstadoControls:ingresar()
    
end

function EstadoControls:salir()
    
end