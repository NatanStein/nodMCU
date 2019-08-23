local led2 = 6
gpio.mode(led2,gpio.OUTPUT) 
gpio.write (led2,gpio.LOW)
local apagado = true 
local function piscapisca (t) 
  apagado = not apagado 
  if apagado then 
    gpio.write(led2 , gpio .LOW )
  else 
    gpio.write(led2 ,gpio.HIGH) 
  end 
end
local mytimer = tmr.create() 
mytimer:register(500,tmr.ALARM_AUTO,piscapisca) 
mytimer:start()