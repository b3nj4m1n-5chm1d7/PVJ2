--Se llama a las clases
require("jugador")
require("enemigo")
require("animacionAtaque")
require("animaciones")

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

    --=================Definicion de variables para canciones/sonidos=============
    musica = love.audio.newSource("sound/musica.mp3", "stream")
    musica:setLooping(true)
    musica:setVolume(0.3)
    love.audio.play(musica)

    sfx = love.audio.newSource("sound/daño.wav", "static")

    derrota= love.audio.newSource("sound/derrota.mp3", "stream")
    derrota:setLooping(false)

    victoria = love.audio.newSource("sound/victoria.mp3", "stream")
    victoria:setLooping(true)
    victoria:setVolume(0.5)
    --===========================================================================

    --Crea un canvas donde dibujar los elementos
    lienzo = love.graphics.newCanvas(ventana.ancho, ventana.alto)

    --Carga de animaciones
    animaciones.Load()

    --Carga de elementos del jugador
    jugador.Crear()

    math.randomseed(os.time())

    --Creacion de enemigo
    enemigo.Crear(enemigo, 100, 100, "img/orco.png")

end

--===============Deteccion del espacio===============
function love.keypressed(key)
    if key == "space" and not ataque then
        ataque = true
    end
end

--=================Actualizacion de los elementos en pantalla================
function love.update(dt)

    if Ganar or Perder then
        return
    end

    --Movimientos
    jugador.Mover(dt)

    enemigo.Mover(enemigo,jugador.x,jugador.y,15,dt)

    animaciones.Update(dt)

    --Hitboxes
    jugador.HitBox()

    enemigo.HitBox(enemigo)

    --Verificacion Coliciones
    atrapado = comprobarColison(jugador.hitbox_x,jugador.hitbox_y,jugador.ancho / 4,jugador.altura / 4,enemigo.hitbox_x,enemigo.hitbox_y,(enemigo.ancho)/30,(enemigo.altura)/18)

    if atrapado then
        enemigo.reinicio(enemigo,100,150)
        
        if ataque then
            love.audio.stop(sfx)
            enemigo.reinicio(enemigo,100,150)

            jugador.derrotados = jugador.derrotados + 1

            --Verifica la victoria
            if jugador.derrotados == jugador.objetivo then
                Ganar = true

                love.audio.stop(musica)
                
                love.audio.play(victoria)
            end

        else

            vidas = vidas - 1
            love.audio.play(sfx)

            --Verifica la derrota
            if vidas <= 0 then

                Perder = true

                love.audio.stop(musica)

                love.audio.play(derrota)
            end
        end
    end
end

--===================Etapa de Dibujo============================
function love.draw()

    love.graphics.setCanvas(lienzo)

    --Se limpia el fondo, para no dejar imagen residual
    love.graphics.clear()

    --Dibujo de los distintos elementos
    jugador.Draw()

    enemigo.Draw(enemigo)

    animaciones.Draw()
    
    debugHitboxes()

    love.graphics.setCanvas()

    love.graphics.draw(lienzo,0,0,0,ventana.escala,ventana.escala)

    --Interfaz/informacion en pantalla
    if not Perder then
        love.graphics.print("Vidas "..vidas,10,10)
    end

    if not Ganar then
        love.graphics.print("Objetivo "..jugador.derrotados.. "/".. jugador.objetivo,700,10)
    end
end