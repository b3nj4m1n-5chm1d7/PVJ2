--======================Tablas del enemigo===============================
enemigo = {}

enemigo2 = {
    crear = enemigo.Crear,
    mover = enemigo.Mover,
    dibujar = enemigo.Draw
}


--Se utiliza self, para la adaptación de un segundo enemigo o más, sin tener que repetir codigo


--=================Calcula direeccion aleatoria para la aparicion de enemigos=============
function enemigo.reinicio(self, x, y)

    local borde = math.random(1,4)
    if borde == 1 then
        self.x = math.random(0,ventana.ancho)
        enemigo.y = 0

        elseif borde == 2 then
            self.x = math.random(0, ventana.ancho)
            self.y = ventana.alto

            elseif borde == 3 then
                self.x = 0
                self.y = math.random(0,ventana.alto)

            elseif borde == 4 then
                self.x = ventana.ancho
                self.y = math.random(0,ventana.alto)
    end

end

--=======================Elementos definidos del enemigo==========================
function enemigo.Crear(self, x, y, ruta)

    self.x = x
    self.y = y

    self.escala = 0.07

    self.sprite = love.graphics.newImage(ruta)

    --Calculo Altos y Anchos
    self.ancho = self.sprite:getWidth()
    self.altura = self.sprite:getHeight()

    --Calculo Origenes
    self.origenx = self.ancho/2
    self.origeny = self.altura/2

    self.hitbox_x = 0
    self.hitbox_y = 0

    self.velocidad = 30

end

--====================Movimiento del enemigo, en base a la posicion del jugador====================
function enemigo.Mover(self, x, y, a, dt)
    
    --Calcula la distancia entre jugador y enemigo en base a la diferencia de esta
    local distx = math.abs(self.x - x)
    local disty = math.abs(self.y - y)

    --Diferencia en X
    if distx > disty then
        if distx > a then
            if self.x > x then
                self.x = self.x - (self.velocidad * dt)
            elseif self.x < x then
                self.x = self.x + (self.velocidad * dt)
            end
        end
    else
        --Diferencia en Y
        if disty > a then
            if self.y < y then
                self.y = self.y + (self.velocidad * dt)
            elseif enemigo.y > y then
                self.y = self.y - (self.velocidad * dt)
            end 
        end 
    end

end

--=================Hitbox====================
function enemigo.HitBox(self)

    self.hitbox_x = self.x - (self.origenx)/27

    self.hitbox_y = self.y - (self.origeny)/18

end

--======================Dibujo simple de un sprite======================
function enemigo.Draw(self)
    
    love.graphics.draw(self.sprite,self.x,self.y,0,self.escala,self.escala,self.origenx,self.origeny)

end

--=========================Dibujo del hitbox y centro==========================
function enemigo.Debug(self)
    
    love.graphics.setColor(1,0,0)
    love.graphics.rectangle("line",self.hitbox_x,self.hitbox_y,25,30)
    love.graphics.setColor(1,1,1)

    love.graphics.circle("fill",self.x,self.y,1)

end