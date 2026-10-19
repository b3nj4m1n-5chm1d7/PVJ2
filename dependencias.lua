--https://github.com/vrld/hump/blob/master/class.lua
Class = require 'lib.class'
Timer = require 'lib.timer'

--Eventos
require "eventos"

--Classes
require "lua antiguos/jugador"
require "lua antiguos/enemigo"
require "lua antiguos/animacionAtaque"
require "animaciones"
require "nave"
require "asteroide"
require "disparo"

--Estados
require "estado"
require "estadoJugar"
require "estadoTitulo"
require "maquinaEstado"
require "estadoDerrota"
require "estadoInstrucciones"
require "estadoVictoria"