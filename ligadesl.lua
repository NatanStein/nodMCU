local red=3
local verde = 6
local sw = 1
local sw2 = 2
gpio.mode(verde,gpio.OUTPUT)
gpio.mode(red,gpio.OUTPUT)
gpio.mode(sw,gpio.INT,gpio.PULLUP)
gpio.mode(sw2,gpio.INT,gpio.PULLUP)
local apagado = true 
gpio.write(red,gpio.LOW)
local lasttime = tmr.now()
local function cbchave (level,time) 
  if time >= lasttime + 250000 then 
    lasttime = time
    apagado = not apagado
    if apagado then 
      gpio.write(red,gpio.LOW) 
    else 
      gpio.write(red,gpio.HIGH)
    end 
  end 
end
gpio.trig(sw,"down",cbchave)