animaciones = {}

atrapado = false

--Informacion para la animacion / spritesheet
spritesheet = nil
quad = {
    origenx = 0,
    origeny = 0
}
indice = 1
--===========================================

ataque = false

golpear = nil

--==============Se definen/cargan los elementos correspondientes==========
function animaciones.Load()

    golpear = love.audio.newSource("sound/ataque.ogg", "static")
    golpear:setVolume(1)

    spritesheet = love.graphics.newImage("img/ataque.png")
    
    --Separacion por secciones para spritesheets simples
    for i = 0, 7 do
        quad[i + 1] = love.graphics.newQuad(155 * i, 0, 155, 118, spritesheet)
    end

end

--==============Establece una actualizacion /animacion==============
function animaciones.Update(dt)

    if ataque then

        --Se establece la velocidad, en base a los fps
        indice = indice + (15 * dt)

        if indice >= #quad + 1 then
            indice = 1
            ataque = false
            love.audio.play(golpear)
        end
    end

end

--========================Dibujado de animacion de ataque==========================
function animaciones.Draw()
    
    local i = math.floor(indice)

    if ataque then

        love.graphics.draw(spritesheet,quad[i], jugador.hitbox_x - 25, jugador.hitbox_y - 25 , 0, 0.5,0.4,quad[i].origenx,quad[i].origeny)
    
    end

end