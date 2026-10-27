--Se llama a las dependencias
require("dependencias")

--Tabla de la ventana
ventana = {
    ancho = 250,
    alto = 144,
    escala = 5
}

Debug = false
pausa = false

--==================Se cargan variables para Canciones=================
musica = nil

sfx = nil

derrota = nil

victoria = nil

preludio = nil
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

    --Hitboxes y centros visibles
    nave.Debug()
    asteroide.Debug()
    Disparo.Debug()

    love.graphics.setColor(1,1,1)
    
end

--==================Carga de Elementos=================================
function love.load()

    --Crea una pantalla personalizada
    love.window.setMode(ventana.ancho * ventana.escala, ventana.alto * ventana.escala)
    
    --Establece un filtro para los sprites, especialmente pixelarts
    love.graphics.setDefaultFilter("nearest","nearest")

    --Se Establecen las fuentes
    fuente1 = love.graphics.newFont('fuente/KZ_SCRATCHER.TTF', 150)
    fuente2 = love.graphics.newFont('fuente/Bring Me A Helicopter!.otf', 120)
    fuente3 = love.graphics.newFont('fuente/PixelO10Bott-Regular.ttf', 30)
    fuente4 = love.graphics.newFont('fuente/Espía Húngaro.otf', 40)

    MaquinaEstadoGlobal = MaquinaEstado {
        ['jugar'] = function () return EstadoJugar() end,
        ['titulo'] = function ()return EstadoTitulo() end,
        ['derrota'] = function () return EstadoDerrota() end,
        ['controles'] = function () return EstadoControls() end,
        ['victoria'] = function () return EstadoVictoria() end
    }

    MaquinaEstadoGlobal:cambiar('titulo')

end

--===============Deteccion del Teclas===============
function love.keypressed(key)

    if key == "1" then
        
        Debug = not Debug
        
    end

    if key == "space" and Disparo and not Disparo.activo then

        Eventos.emitir("reinicio")

        Disparo.activo = true
        love.audio.stop(Disparo.laser)
        love.audio.play(Disparo.laser)
        
    end

    if key == "return" then
        MaquinaEstadoGlobal:cambiar('controles')
    end

    if key == "escape" then

        love.audio.stop()
        MaquinaEstadoGlobal:cambiar('titulo')

    end

    if key == "p" then

        Eventos.emitir("DetenerAsteroide")
        Eventos.emitir("DetenerNave")
        pausa = true

    end

    if key == "a" then
        
        Eventos.emitir("ActivarAsteroide")
        Eventos.emitir("ActivarNave")
        pausa = false

    end

    if key == "o" or key == "0" then
        
        love.audio.stop()
        MaquinaEstadoGlobal:cambiar('jugar')
        asteroide.activo = true
        nave.activo = true
        vidas = 5
        jugador.derrotados = 0

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