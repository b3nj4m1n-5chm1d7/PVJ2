ventana = {
    ancho = 160,
    alto = 144,
    escala = 5
}

jugador = {
    x = 0,
    y = 0,
    sprite = nil,
    escala = 0.13,
    origenx = 0,
    origeny = 0,
    ancho = 0,
    altura = 0,
    velocidad = 50,

    hitbox_x = 0,
    hitbox_y = 0
}

enemigo = {
    x = 100,
    y = 100,
    sprite = nil,
    escala = 0.065,
    velocidad = 25,
    origenx = 0,
    origeny = 0,
    ancho = 0,
    altura = 0,

    hitbox_x = 0,
    hitbox_y = 0
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
        --Hitboxes visibles
        love.graphics.setColor(0, 0, 1)
        love.graphics.rectangle("line",jugador.hitbox_x,jugador.hitbox_y,25,30)
        love.graphics.setColor(1,0,0)
        love.graphics.rectangle("line",enemigo.hitbox_x,enemigo.hitbox_y,25,30)
        love.graphics.setColor(1,1,1)
    
        --Centros de los personajes
        love.graphics.circle("fill",jugador.x,jugador.y,1)
        love.graphics.circle("fill",enemigo.x,enemigo.y,1)
 
    end
    
end

function love.load()

    love.window.setMode(ventana.ancho * ventana.escala, ventana.alto * ventana.escala)
    
    love.graphics.setDefaultFilter("nearest","nearest")

    lienzo = love.graphics.newCanvas(ventana.ancho, ventana.alto)

    jugador.sprite = love.graphics.newImage("pato.png")

    enemigo.sprite = love.graphics.newImage("orco.png")

    --Calculo Altos y Anchos
    jugador.ancho = jugador.sprite:getWidth()
    jugador.altura = jugador.sprite:getHeight()
    enemigo.ancho = enemigo.sprite:getWidth()
    enemigo.altura = enemigo.sprite:getHeight()

    --Calculo Origenes
    jugador.origenx = jugador.ancho/2
    jugador.origeny = jugador.altura/2
    enemigo.origenx = enemigo.ancho/2
    enemigo.origeny = enemigo.altura/2

    --Centrado
    jugador.x = ventana.ancho/2
    jugador.y = ventana.alto/2

end

function love.update(dt)

    if love.keyboard.isDown("right") then
        jugador.x = jugador.x + (jugador.velocidad * dt)
    elseif love.keyboard.isDown("left") then
        jugador.x = jugador.x - (jugador.velocidad * dt)
    elseif love.keyboard.isDown("up") then
        jugador.y = jugador.y - (jugador.velocidad * dt)
    elseif love.keyboard.isDown("down") then
        jugador.y = jugador.y + (jugador.velocidad * dt)
    end

    local distx = math.abs(enemigo.x - jugador.x)
    local disty = math.abs(enemigo.y - jugador.y)

    --Calculo Distancias
    if distx > disty then
        if distx > 20 then
            if enemigo.x > jugador.x then
                enemigo.x = enemigo.x - (enemigo.velocidad * dt)
            elseif enemigo.x < jugador.x then
                enemigo.x = enemigo.x + (enemigo.velocidad * dt)
            end
        end
    else
        if disty > 29 then
            if enemigo.y < jugador.y then
                enemigo.y = enemigo.y + (enemigo.velocidad * dt)
            elseif enemigo.y > jugador.y then
                enemigo.y = enemigo.y - (enemigo.velocidad * dt)
            end 
        end 
    end

    --Calculo Hitboxes
    jugador.hitbox_x = jugador.x - (jugador.origenx)/6.5
    jugador.hitbox_y = jugador.y - (jugador.origeny)/8

    enemigo.hitbox_x = enemigo.x - (enemigo.origenx)/27
    enemigo.hitbox_y = enemigo.y - (enemigo.origeny)/18

    --Verificacion Coliciones
    atrapado = comprobarColison(jugador.hitbox_x,jugador.hitbox_y,(jugador.ancho)/6.5,(jugador.altura)/8,enemigo.hitbox_x,enemigo.hitbox_y,(enemigo.ancho)/30,(enemigo.altura)/18)
end

function love.draw()

    love.graphics.setCanvas(lienzo)

    love.graphics.clear()

    love.graphics.draw(jugador.sprite,jugador.x,jugador.y,0,jugador.escala,jugador.escala,jugador.origenx,jugador.origeny)

    love.graphics.draw(enemigo.sprite,enemigo.x,enemigo.y,0,enemigo.escala,enemigo.escala,enemigo.origenx,enemigo.origeny)

    debugHitboxes()

    love.graphics.setCanvas()

    love.graphics.draw(lienzo,0,0,0,ventana.escala,ventana.escala)

    if atrapado then
        love.graphics.print("ATRAPADO",100,10)
    end
end