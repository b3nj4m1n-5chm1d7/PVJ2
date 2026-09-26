--Se llama a las dependencias
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

--Fuentes
fuente1 = nil
fuente2 = nil
fuente3 = nil
fuente4 = nil

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

    --Se Establecen las fuentes
    fuente1 = love.graphics.newFont('fuente/Vengeance at Sea.otf', 110)
    fuente2 = love.graphics.newFont('fuente/Bring Me A Helicopter!.otf', 120)
    fuente3 = love.graphics.newFont('fuente/Klaxon-Smooth.otf', 30)
    fuente4 = love.graphics.newFont('fuente/Vengeance at Sea.otf', 40)

    MaquinaEstadoGlobal = MaquinaEstado {
        ['jugar'] = function () return EstadoJugar() end,
        ['titulo'] = function ()return EstadoTitulo() end,
        ['derrota'] = function () return EstadoDerrota() end
    }

    MaquinaEstadoGlobal:cambiar('titulo')
end

--===============Deteccion del Teclas===============
function love.keypressed(key)

    if key == "space" and not ataque then
        ataque = true
    end

    if key == "return" then
        MaquinaEstadoGlobal:cambiar('jugar')
        love.audio.stop(derrota)
        vidas = 5
        jugador.derrotados = 0
    end

    if key == "escape" then
        MaquinaEstadoGlobal:cambiar('titulo')
        love.audio.stop(musica)
        love.audio.stop(victoria)
        love.audio.stop(derrota)
    end

end

--=================Actualizacion de los elementos en pantalla================
function love.update(dt)

    MaquinaEstadoGlobal:actualizar(dt)

end

--===================Etapa de Dibujo============================
function love.draw()

    MaquinaEstadoGlobal:dibujar()

end