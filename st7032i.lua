-- ST7032i LCD (16x2 in my case)
-- needs i2clib set via i2clib=require("i2clib")

local M = {}

M.addr = 0x3E

     
--[[
M.XXXsend_i2c = function(value, mode)
         i2c.start(0)
         i2c.address(0, 0x3E, i2c.TRANSMITTER)
         i2c.write(0, mode)
         i2c.write(0, value)       
         i2c.stop(0)   
end
]]

M.lcd_command = function(value)
    i2clib.write_reg(M.addr, 0x00, value)
end


M.lcd_write = function(value)
    i2clib.write_reg(M.addr, 0x40, value)
end

 
M.lcd_init = function ()
        M.lcd_command(0x38);      -- function set  basic
        tmr.delay(300);
        M.lcd_command(0x39);      -- function set extended
        tmr.delay(300);
        M.lcd_command(0x14);      -- internal OCS frequency adjustment
        tmr.delay(300);
        M.lcd_command(0x69);      -- contrast set low nible
        tmr.delay(300);
        M.lcd_command(0x54);      -- contrast set high nible / icon / power
        tmr.delay(300);
        M.lcd_command(0x6f);       --  follower control
        tmr.delay(200000);
        M.lcd_command(0x0c);      --  display on
        tmr.delay(300);
        M.lcd_command(0x01);      -- clear display
        tmr.delay(350000);
        M.lcd_command(0x06);      -- entry mode set
        tmr.delay(300);
        M.lcd_command(0x02);      -- home
        tmr.delay(1000000);
end  


M.lcd_clear = function()
        M.lcd_command(0x01)
        tmr.delay(350000)
end
   

M.lcd_setCursor = function(col, row)
        local row_offsets = { 0x00, 0x40, 0x14, 0x54 }
--[[
        if ( row > 2 ) then
           row = 2-1
        end
]]--
        M.lcd_command(bit.bor(0x80,(col + row_offsets[row])))
        tmr.delay(300)
end

return M

