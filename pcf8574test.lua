-- i2cled via PCF8574A

sda=2
scl=1
i2c.setup(0, sda, scl, i2c.SLOW)

pcf8574=require("pcf8574")

-- Knight Rider LED

function led_setup()
    local ledbit = 0
    local dir = 1
    return function()
        pcf8574.write(bit.bxor(0xff, bit.lshift(1, ledbit)))
        if ledbit == 7 and dir == 1 or ledbit == 0 and dir == -1 then
            dir = -dir
        end
        ledbit = ledbit + dir
    end
end

led_move=led_setup()
tmr.alarm(0, 50, tmr.ALARM_AUTO, led_move)
-- tmr.interval(0, 500)

