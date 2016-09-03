-- PCF8583 RTC
-- needs i2clib set via i2clib=require("i2clib")

local M = {}

M.addr = 0x51

M.bcd2bin = function(n)
    local left = bit.rshift(n, 4)
    local right = bit.band(n, 0x0F)
    return left*10+right
end

M.time_string = function()
    local s = i2clib.read_reg(M.addr, 1, 4)
    local hsec = M.bcd2bin(string.byte(s, 1))
    local sec = M.bcd2bin(string.byte(s, 2))
    local min = M.bcd2bin(string.byte(s, 3))
    local hour = M.bcd2bin(string.byte(s, 4))
    return string.format("%2d:%02d:%02d.%02d", hour, min, sec, hsec)
end

M.bin2bcd = function(n)
    local left = n/10
    local right = n%10
    return bit.lshift(left, 4)+right
end

-- Set time, but ignore year

M.settime = function(h, m, s, year, month, day)
    local str = {}
    str[1] = M.bin2bcd(0)
    str[2] = M.bin2bcd(s)
    str[3] = M.bin2bcd(m)
    str[4] = M.bin2bcd(h)
    str[5] = M.bin2bcd(day)
    str[6] = M.bin2bcd(month)
    i2clib.write_reg(M.addr, 1, str)
end

return M


-- Test

--i2clib=require("i2clib")
--pcf8583.init(0, 2, 1)

--status=read_reg(pcf8583.addr, 0, 1)
--print(string.byte(status,1))
--pcf8583.displaytime()

-- Set time

--pcf8583.settime(22, 07, 0, 0, 9, 2)
--pcf8583.displaytime()

