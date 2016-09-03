-- i2c lib
-- Very simple, but all modules need this

local M = {}

-- user defined function: read from reg_addr content of dev_addr
-- Return a string of bytes which we read from the device

function M.read_reg(dev_addr, reg_addr, len)
    i2c.start(0)
    i2c.address(0, dev_addr, i2c.TRANSMITTER)
    i2c.write(0, reg_addr)
    i2c.stop(0)
    i2c.start(0)
    i2c.address(0, dev_addr, i2c.RECEIVER)
    local s = i2c.read(0, len)
    i2c.stop(0)
    return s
end

-- user defined function: write
function M.write_reg(dev_addr, reg_addr, value)
    i2c.start(0)
    i2c.address(0, dev_addr, i2c.TRANSMITTER)
    i2c.write(0, reg_addr)
    i2c.write(0, value)
    i2c.stop(0)
end

function M.init(sda, scl)
    i2c.setup(0, sda, scl, i2c.SLOW)
end

return M
