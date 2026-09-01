require("animaciones")

--===================Tabla del jugador========================
jugador = {
    x = 0,
    y = 0,
    sprite = nil,
    escala = 1,
    origenx = 0,
    origeny = 0,
    ancho = 0,
    altura = 0,
    velocidad = 50,

    hitbox_x = 0,
    hitbox_y = 0,

    direccion = 1,

    correr = nil,

    derrotados = 0,
    objetivo = 10
}

--========================Definicion de elementos del jugador========================
function jugador.Crear()

    jugador.correr = CrearAnimacion("img/personaje.png",3,16,24,12)

    --Calculo Alto y Ancho
    jugador.ancho = jugador.correr.spritesheet:getWidth()
    jugador.altura = jugador.correr.spritesheet:getHeight()

    --Calculo Origenes
    jugador.origenx = jugador.ancho/8
    jugador.origeny = jugador.altura/8

    --Centrado
    jugador.x = ventana.ancho/2
    jugador.y = 10

end

--=====================Movimientos del jugador================================
function jugador.Mover(dt)

     if love.keyboard.isDown("right") then

        jugador.x = jugador.x + (jugador.velocidad * dt)

        jugador.direccion = 4


    elseif love.keyboard.isDown("left") then

        jugador.x = jugador.x - (jugador.velocidad * dt)

        jugador.direccion = 3


    elseif love.keyboard.isDown("up") then

        jugador.y = jugador.y - (jugador.velocidad * dt)

        jugador.direccion = 2

        
    elseif love.keyboard.isDown("down") then

        jugador.y = jugador.y + (jugador.velocidad * dt)

        jugador.direccion = 1

    end


        jugador.correr.indice = jugador.correr.indice + (12 * dt)
        if jugador.correr.indice >= #jugador.correr.quad[jugador.direccion] then
            jugador.correr.indice = 1
        end

end

--=========================Calculo para la hitbox del jugador=====================
function jugador.HitBox()

    jugador.hitbox_x = jugador.x - (jugador.origenx)/2

    jugador.hitbox_y = jugador.y - (jugador.origeny)/2

end

--====================Dibuja al jugador===============================
function jugador.Draw()

    local i = math.floor(jugador.correr.indice)
    love.graphics.draw(jugador.correr.spritesheet,jugador.correr.quad[jugador.direccion][i], jugador.hitbox_x + 8, jugador.hitbox_y  + 2, 0, jugador.escala, jugador.escala,jugador.origenx,jugador.origenx)

    
end

--==============Dibuja la hitbox del jugador===============================
function jugador.Debug()
    
    love.graphics.setColor(0, 0, 1)
    love.graphics.rectangle("line",jugador.hitbox_x,jugador.hitbox_y,15,15)

    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill",jugador.x,jugador.y,1) -- Por el momento, el punto no se encuentra en el centro del sprite

end