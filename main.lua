require("jugador")
require("enemigo")

ventana = {
    ancho = 160,
    alto = 144,
    escala = 5
}

atrapado = false

function comprobarColison(x1, y1, ancho1, alto1, x2, y2, ancho2, alto2)
return x1 < x2 + ancho2 and
    x2 < x1 + ancho1 and
    y1 < y2 + alto2 and
    y2 < y1 + alto1
end

function debugHitboxes()
    if love.keyboard.isDown("h") then

        --Hitboxes y centros visibles
        jugador.Debug()
        enemigo.Debug(enemigo)
        enemigo.Debug(enemigo2)

    end
    
end

function love.load()

    love.window.setMode(ventana.ancho * ventana.escala, ventana.alto * ventana.escala)
    
    love.graphics.setDefaultFilter("nearest","nearest")

    lienzo = love.graphics.newCanvas(ventana.ancho, ventana.alto)

    jugador.Crear()

    enemigo.Crear(enemigo, 100, 100, "orco.png")
    enemigo.Crear(enemigo2, 30, 100, "malo.png")

end

function love.update(dt)

    jugador.Mover(dt)

    enemigo.Mover(enemigo,jugador.x,jugador.y,20,dt)
    enemigo.Mover(enemigo2,jugador.x,jugador.y,20,dt)

    --Hitboxes
    jugador.HitBox()

    enemigo.HitBox(enemigo)
    enemigo.HitBox(enemigo2)

    --Verificacion Coliciones
    atrapado = comprobarColison(jugador.hitbox_x,jugador.hitbox_y,(jugador.ancho)/6.5,(jugador.altura)/8,enemigo.hitbox_x,enemigo.hitbox_y,(enemigo.ancho)/30,(enemigo.altura)/18)

end

function love.draw()

    love.graphics.setCanvas(lienzo)

    love.graphics.clear()

    jugador.Draw()

    enemigo.Draw(enemigo)
    enemigo.Draw(enemigo2)

    debugHitboxes()

    love.graphics.setCanvas()

    love.graphics.draw(lienzo,0,0,0,ventana.escala,ventana.escala)

    if atrapado then
        love.graphics.print("ATRAPADO",100,10)
    end
end