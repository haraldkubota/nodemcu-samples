# nodemcu-samples

Some NodeMCU examples, mainly to interface I/O devices I happen to have.

Data sheets for all used chips are readily available on the Internet. You'll need them to understand and modify the libraries.

## lcd_clock.lua
### Hardware Requirements
* NodeMCU module (or similar)
* PCF8583 RTC module (http://www.futurlec.com/Mini_PCF8583.shtml)
* LCD with ST7032i (http://strawberry-linux.com/catalog/items?code=27003)
* NodeMCU I2C connections: D2=SDA, D1=SCL
* 3.3V and GND from NodeMCU modules to Vcc of both the RTC module and the I2C LCD
### Requirements
* Modules: i2clib, rtc8583 and st7032i and lcd_clock
* NodeMCU firmware needs I2C module. I use 1.5.4 with floating point
* To run: dofile("lcd_clock")
* Can be run as init.lua
### Photos
* https://goo.gl/photos/9bFZxCHkD5r92GBU8

## pcf8574test.lua
### Hardware Requirements
* PCF8574A at I2C address 0x38
* LEDs connected to the output pins of the PCF8574A (LED's lit when logic level is 0)

### Requirements
* Modules: pcf8574
* To run: dofile("pcf8574test")

## Thanks

* http://www.esp8266-projects.com/2015/03/display-time-st7032i-i2c-lcd-display.html for the ST7032i module. I was wondering why my own module did not work, so I was glad to find a working module. In the end it turned out that /RESET needed to be connected before the display which I had would display anything.


