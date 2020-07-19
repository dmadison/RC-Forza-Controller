# RC Controller for Forza
This project converts a DUMBORC x4 remote control for an RC car into a controller for [Forza Horizon 4](https://forzamotorsport.net/en-us/games/fh4). A USB-capable microcontroller reads the receiver's PWM pulses and translates the signals into Xbox controller (XInput) inputs for the game.

For more information, check out the article on [PartsNotIncluded.com](https://www.partsnotincluded.com/modifying-an-rc-controller-to-play-forza-horizon).

## Dependencies
The microcontroller code has several dependencies:

* [ArduinoXInput](https://github.com/dmadison/ArduinoXInput) [(v1.2.3)](https://github.com/dmadison/ArduinoXInput/releases/tag/v1.2.3)
* [ServoInput](https://github.com/dmadison/ServoInput) [(v1.0.0)](https://github.com/dmadison/ServoInput/releases/tag/v1.0.0)
* [ArduinoXInput AVR Core](https://github.com/dmadison/ArduinoXInput_AVR) [(v1.0.1)](https://github.com/dmadison/ArduinoXInput_AVR/releases/tag/v1.0.1)

I've linked to the specific releases that work with this code. Note that other versions may not be compatible.

This project was compiled using version 1.8.12 of the Arduino IDE. Microcontrollers other than the ATmega32U4 may be compatible but have not been tested.

## License
This project is licensed under the terms of the [GNU General Public License](https://www.gnu.org/licenses/gpl-3.0.en.html), either version 3 of the License, or (at your option) any later version.
