local red=3
local verde = 6
local sw = 1
local sw2 = 2
cont=1
sec=""
compsec=""
cont2=0
lasttime=0
math.randomseed(tmr.now())
gpio.mode(verde,gpio.OUTPUT)
gpio.mode(red,gpio.OUTPUT)
gpio.mode(sw,gpio.INT,gpio.PULLUP)
gpio.mode(sw2,gpio.INT,gpio.PULLUP)
gpio.write(red,gpio.LOW)
gpio.write(verde,gpio.LOW)
local cbchave , restabelece 
local mytimer = tmr.create()
local mytimer2 = tmr.create()
function ascred (level,time)
 if time >= lasttime + 300000 then
  lasttime = time
  if cont2 < 7 then
    if cont2 == 0 then
      criasec()
    else
      gpio.write(red,gpio.HIGH)
      tmr.delay(500000)
      gpio.write(red,gpio.LOW)
      compsec=compsec.."1"
      cont2=cont2+1
      gpio.trig(sw)
      mytimer:alarm (500,tmr.ALARM_SINGLE,restabelece)
      if cont2 == 6 then
        verifica(sec,compsec)
        cont2=7
      end
  end
 else
   gpio.write(verde,gpio.LOW) 
   gpio.write(red,gpio.LOW) 
  end
 end
end
function restabelece() 
  gpio.trig(sw,"down",ascred) 
end
function ascverde (level,time)
  if time >= lasttime + 300000 then
    lasttime = time
    if cont2 < 7 then
      gpio.write(verde,gpio.HIGH)
      tmr.delay(500000)
      gpio.write(verde,gpio.LOW)
      compsec=compsec.."0"
      cont2=cont2+1
      gpio.trig(sw2)
      mytimer2:alarm (500,tmr.ALARM_SINGLE,restabelece2)
      if cont2 == 6 then
        verifica(sec,compsec)
        cont2=7
      end
    else
      gpio.write(verde,gpio.LOW) 
      gpio.write(red,gpio.LOW) 
    end
  end
end
function restabelece2() 
  gpio.trig(sw2,"down",ascverde) 
end
function verifica (sec,compsec)
  tmr.delay(500000)
  if sec == compsec then
    gpio.write(verde,gpio.HIGH)
  else
    gpio.write(red,gpio.HIGH)
  end
end
function criasec ()
  tmr.delay(500000)
  while cont <= 5 do
    num=math.random(0,1)
    if num == 1 then
      gpio.write(red,gpio.HIGH)
      tmr.delay(500000)
      gpio.write(red,gpio.LOW)
      sec=sec..tostring(num)
    else
      gpio.write(verde,gpio.HIGH)
      tmr.delay(500000)
      gpio.write(verde,gpio.LOW) 
      sec=sec..tostring(num)
    end
    cont=cont+1
    tmr.delay(500000)
    cont2=1
  end
end
gpio.trig(sw,"down",ascred)
gpio.trig(sw2,"down",ascverde)