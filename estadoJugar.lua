EstadoJugar = Class {_includes = Estado}

function EstadoJugar:init()

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

function EstadoJugar:draw()
    
    love.graphics.setCanvas(lienzo)

    --Se limpia el fondo, para no dejar imagen residual
    love.graphics.clear()

    --Dibujo de los distintos elementos
    jugador.Draw()

    enemigo.Draw(enemigo)

    animaciones.Draw()

    --Dibuja las hitbox y centros de los elementos
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

function EstadoJugar:actualizar(dt)

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

function EstadoJugar:ingresar() end

function EstadoJugar:salir() end