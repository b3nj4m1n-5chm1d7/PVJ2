enemigo = {}

enemigo2 = {
    crear = enemigo.Crear,
    mover = enemigo.Mover,
    dibujar = enemigo.Draw
}

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

    self.velocidad = 40

end

function enemigo.Mover(self, x, y, a, dt)
    
    local distx = math.abs(self.x - x)
    local disty = math.abs(self.y - y)

    if distx > disty then
        if distx > 20 then
            if self.x > x then
                self.x = self.x - (self.velocidad * dt)
            elseif self.x < x then
                self.x = self.x + (self.velocidad * dt)
            end
        end
    else
        if disty > 29 then
            if self.y < y then
                self.y = self.y + (self.velocidad * dt)
            elseif enemigo.y > y then
                self.y = self.y - (self.velocidad * dt)
            end 
        end 
    end

end

function enemigo.HitBox(self)

    self.hitbox_x = self.x - (self.origenx)/27

    self.hitbox_y = self.y - (self.origeny)/18

end

function enemigo.Draw(self)
    
    love.graphics.draw(self.sprite,self.x,self.y,0,self.escala,self.escala,self.origenx,self.origeny)

end

function enemigo.Debug(self)
    
    love.graphics.setColor(1,0,0)
    love.graphics.rectangle("line",self.hitbox_x,self.hitbox_y,25,30)
    love.graphics.setColor(1,1,1)

    love.graphics.circle("fill",self.x,self.y,1)

end