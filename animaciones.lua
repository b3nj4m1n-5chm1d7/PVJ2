--Calculo para animacion con spritesheets poco complejos
function CrearAnimacion(imagen, limite, ancho, alto, velocidad)
    
    local animacion = {}

    animacion.spritesheet = love.graphics.newImage(imagen)
    animacion.indice = 1
    animacion.quad = {}
    animacion.activado = true

    for fila = 0, 3 do
        
        animacion.quad[fila + 1] = {}

        for columna = 0, limite do
            
            table.insert(animacion.quad[fila + 1], love.graphics.newQuad(ancho * columna, alto * fila, ancho, alto, animacion.spritesheet:getWidth(), animacion.spritesheet:getHeight()))

        end
    end

    return animacion

end