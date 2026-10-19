EstadoJugar = Class {_includes = Estado}

fondo = nil

function EstadoJugar:init()

    --=================Definicion de variables para canciones/sonidos=============
    musica = love.audio.newSource("sound/Juego.mp3", "stream")
    musica:setLooping(true)
    musica:setVolume(1)
    love.audio.play(musica)

    sfx = love.audio.newSource("sound/daño.wav", "static")

    derrota= love.audio.newSource("sound/Perder.mp3", "stream")
    derrota:setLooping(true)

    victoria = love.audio.newSource("sound/Ganar.mp3", "stream")
    victoria:setLooping(true)
    victoria:setVolume(0.5)
    --===========================================================================

    --Crea un canvas donde dibujar los elementos
    lienzo = love.graphics.newCanvas(ventana.ancho, ventana.alto)

    --Carga de animaciones
    animaciones.Load()
    
    --Carga de elementos del jugador
    nave.Crear()

    math.randomseed(os.time())

    Disparo.Carga()

    asteroide.Crear()

    fondo = love.graphics.newImage("img/Galaxia.png")

    Eventos.on("colision", function()
        --Colision con la nave
        self.atrapado = comprobarColison(nave.hitbox_x, nave.hitbox_y, 55, 25, asteroide.hitbox_x, asteroide.hitbox_y, 25, 20)
    end)

    Eventos.on("destruir", function()
        --Colicion con el disparo
        self.alcanzado = comprobarColison(Disparo.hitbox_x, Disparo.hitbox_y, Disparo.ancho * Disparo.escala, Disparo.alto * Disparo.escala, asteroide.hitbox_x, asteroide.hitbox_y, asteroide.ancho * asteroide.escala, asteroide.alto * asteroide.escala) 
    end)
end

function EstadoJugar:draw()
    
    love.graphics.setCanvas(lienzo)
    love.graphics.setFont(fuente3)

    --Se limpia el fondo, para no dejar imagen residual
    love.graphics.clear()

    love.graphics.draw(fondo,0,0,0,0.35)

    --Dibujo de los distintos elementos
    nave.Draw()

    animaciones.Draw()

    Disparo.Draw()

    asteroide.Draw()

    if Debug then
        
        --Dibuja las hitbox y centros de los elementos
        debugHitboxes()

    end

    love.graphics.setCanvas()

    love.graphics.draw(lienzo,0,0,0,ventana.escala,ventana.escala)

    --Interfaz/informacion en pantalla
    if not Perder then
        love.graphics.print("Vidas "..vidas,10,10)
    end

    if not Ganar then
        love.graphics.print("Objetivo "..jugador.derrotados.. "/".. jugador.objetivo,1050,10)
    end

    if pausa then
        love.graphics.setColor(0,0,1)
        love.graphics.print("Pausa",(ventana.ancho * ventana.escala) / 2, 300)
        love.graphics.setColor(1,1,1)
        love.graphics.print("Continuar: A", 10, 680)
    end

    if not pausa then
        love.graphics.print("Pausar : P", 10, 680)
    end

end

Eventos.on("perdervidas", function() vidas = vidas - 1 end)
Eventos.on("masPuntos",function() jugador.derrotados = jugador.derrotados + 1 end)

function EstadoJugar:actualizar(dt)

    if self.Ganar or self.Perder then
        return
    end

    --Movimientos
    nave.Mover(dt)

    animaciones.Update(dt)

    Disparo.Mover(dt)

    asteroide.Mover(dt)


    --Hitboxes
    nave.HitBox()
    asteroide.HitBox()
    Disparo.HitBox()

    --Verificacion Coliciones
    Eventos.emitir("colision")
    Eventos.emitir("destruir")

    if self.atrapado then

        Eventos.emitir("perdervidas", vidas)
        love.audio.play(sfx)

        --Verifica la derrota
        if vidas <= 0 then

            self.Perder = true

            love.audio.stop()

            love.audio.play(derrota)

            MaquinaEstadoGlobal:cambiar('derrota')

         end

         Eventos.emitir("asteroideDestruido")

    end

    if self.alcanzado then

        if Disparo.activo then
            
            love.audio.stop(sfx)

            Eventos.emitir("masPuntos")

            --Verifica la victoria
            if jugador.derrotados == jugador.objetivo then

                self.Ganar = true

                love.audio.stop()
                
                love.audio.play(victoria)

                MaquinaEstadoGlobal:cambiar('victoria')

            end

            Eventos.emitir("asteroideDestruido")

        end
    end
end

function EstadoJugar:ingresar() end

function EstadoJugar:salir() end