--Se llama a las clases
require("dependencias")

--Tabla de la ventana
ventana = {
    ancho = 160,
    alto = 144,
    escala = 5
}

--==================Se cargan variables para Canciones=================
musica = nil

sfx = nil

derrota = nil

victoria = nil
--======================================================

vidas = 5

--variables de victoria y derrota
Ganar = false
Perder = false

estado = nil

--====================Establece el calculo para impactos==========================
function comprobarColison(x1, y1, ancho1, alto1, x2, y2, ancho2, alto2)
return x1 < x2 + ancho2 and
    x2 < x1 + ancho1 and
    y1 < y2 + alto2 and
    y2 < y1 + alto1
end

--Dibujo de las hitboxes
function debugHitboxes()
    
    if love.keyboard.isDown("h") then

        --Hitboxes y centros visibles
        jugador.Debug()
        enemigo.Debug(enemigo)

    end
    
end

--==================Carga de Elementos=================================
function love.load()

    --Crea una pantalla personalizada
    love.window.setMode(ventana.ancho * ventana.escala, ventana.alto * ventana.escala)
    
    --Establece un filtro para los sprites, especialmente pixelarts
    love.graphics.setDefaultFilter("nearest","nearest")

    estado = EstadoJugar()

end

--===============Deteccion del Teclas===============
function love.keypressed(key)

    if key == "space" and not ataque then
        ataque = true
    end

end

--=================Actualizacion de los elementos en pantalla================
function love.update(dt)

    estado:actualizar(dt)

end

--===================Etapa de Dibujo============================
function love.draw()

    estado:draw()

end