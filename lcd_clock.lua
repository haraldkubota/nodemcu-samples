function do_the_clock()
    i2clib=require("i2clib")
    sda, scl = 2, 1                           -- declare your I2C pinout
    i2clib.init(sda, scl)                   -- init I2C Bus
    st7032i=require('st7032i')                 --call for new created ST7032i Module Driver
    st7032i.lcd_init()              
    st7032i.lcd_clear()
    st7032i.lcd_setCursor(0,1)   
    st7032i.lcd_write("Hello Clock") 
    st7032i.lcd_setCursor(0,2)
    st7032i.lcd_write("2. Line!")
    
    pcf8583=require('pcf8583')
    
    function lcd_time()
        st7032i.lcd_setCursor(0,1)  
        st7032i.lcd_write(pcf8583.time_string())
    end
    
    tmr.alarm(1, 1000, tmr.ALARM_AUTO, lcd_time)
    tmr.alarm(2, 3500, tmr.ALARM_SINGLE, st7032i.lcd_clear)
end

tmr.alarm(0, 5000, tmr.ALARM_SINGLE, do_the_clock)
