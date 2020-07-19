/*
*  Project     RC Forza Controller
*  @author     David Madison
*  @link       github.com/dmadison/RC-Forza-Controller
*  @license    GPLv3 - Copyright (c) 2020 David Madison
*
*  This program is free software: you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation, either version 3 of the License, or
*  (at your option) any later version.
*
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*
*  You should have received a copy of the GNU General Public License
*  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*
*/

#if defined(__AVR_ATmega32U4__)  // Arduino Pro Micro / Leonardo
	#define SERVOINPUT_SUPPRESS_WARNINGS  // enables the use of pin change interrupts in the library
	#define USING_PCINT  // enables the pin change interrupt setup
#endif

#include <ServoInput.h>
#include <XInput.h>

// ServoInput objects, one for each channel
ServoInputPin<0> ch1;  // steering wheel
ServoInputPin<1> ch2;  // speed trigger
ServoInputPin<2> ch3;  // momentary button on grip
ServoInputPin<3> ch4;  // slide switch on grip
ServoInputPin<7> ch5;  // momentary button on top (left)
ServoInputPin<8> ch6;  // momentary button on top (right), PCINT

// Deadzone settings, as a percentage of the total range (applied at center)
const float Deadzone_Steering = 0.15;
const float Deadzone_Throttle = 0.10;

const int16_t ButtonThreshold = 10000;  // ~1/3rd rotation past deadzone (int16_t range)

enum class RC_Mode{
	Extras = 0,
	Race = 1,
	Menu = 2,
} mode = RC_Mode::Race;

#ifdef USING_PCINT
	void setupPCINT() {
		const uint8_t pin = ch6.getPin();
		*digitalPinToPCMSK(pin) |= bit(digitalPinToPCMSKbit(pin));  // enable pin
		PCIFR |= bit(digitalPinToPCICRbit(pin)); // clear any outstanding interrupt
		PCICR |= bit(digitalPinToPCICRbit(pin)); // enable interrupt for the group
	}

	ISR(PCINT0_vect) {  // pin change ISR handler
		ch6.isr();
	}
#else
	void setupPCINT() {}
#endif


void setup() {
	setupPCINT();  // pin change interrupt needed for pin 8 on 32U4

	XInput.setAutoSend(false);
	XInput.begin();

	while (!ServoInput.allAvailable()) {  // wait for all channels to be ready
		Serial.println("Waiting for signals...");
	}
}

void loop() {
	bootloaderCheck();
	modeCheck();

	switch (mode) {
		case(RC_Mode::Race):
			raceMode();
			break;
		case(RC_Mode::Extras):
			extrasMode();
			break;
		case(RC_Mode::Menu):
			menuMode();
			break;
	}

	XInput.send();
}

void modeCheck() {
	static const uint8_t CountThreshold = 5;  // number of updates before switching, 20 ms each (100 ms total)
	static RC_Mode changeMode = mode;  // mode we're working towards
	static uint8_t changeCount = 0;  // # of updates using the new mode

	if (!ch4.available()) return;  // no new data

	RC_Mode newMode = (RC_Mode) ch4.map(0, 2);  // change mode depending on slide position

	if (newMode != mode) {  // mode is different
		if (newMode != changeMode) {
			changeMode = newMode;  // we're working towards *this*
			changeCount = 0;  // reset count
		}
		changeCount++;  // increment count

		if (changeCount >= CountThreshold) {
			XInput.releaseAll();  // clear existing controls
			mode = newMode;
		}
	}
	else {
		changeCount = 0;  // mode is the same, hold count at 0
	}
}


int16_t getServoJoy(ServoInputSignal& sig, float dz, boolean invert = false) {
	int16_t axis = sig.mapDeadzone(-32767, 32767, dz);  // symmetrical range w/ deadzone at '0'.
	if (invert) axis = -axis;
	if (axis == -32767) axis = -32768;  // edge case, max value
	return axis;
}

void setTriggerAxis(int16_t val) {
	// set both the left and right triggers based on a single value (-255 to 255)

	if (val < -255) val = -255;
	else if (val > 255) val = 255;

	uint8_t lt = 0, rt = 0;
	if (val < 0) lt = abs(val);  // less than 0, send to left trigger
	else rt = (uint8_t) val;  // greater than 0, send to right trigger

	XInput.setTrigger(TRIGGER_LEFT, lt);
	XInput.setTrigger(TRIGGER_RIGHT, rt);
}

void raceMode() {
	// CH1: Steering (Left Joy X)
	int16_t steering = getServoJoy(ch1, Deadzone_Steering, true);
	XInput.setJoystickX(JOY_LEFT, steering);

	// CH2: Gas & Brake (Triggers)
	int16_t throttle = ch2.mapDeadzone(-255, 255, Deadzone_Throttle);
	setTriggerAxis(throttle);

	// CH3: Handbrake (A)
	boolean handbrake = !ch3.getBoolean();  // active low
	XInput.setButton(BUTTON_A, handbrake);

	// CH5: Horn (R3)
	boolean horn = ch5.getBoolean();
	XInput.setButton(BUTTON_R3, horn);

	// CH6: Enter Event (X)
	boolean enterEvent = ch6.getBoolean();
	XInput.setButton(BUTTON_X, enterEvent);
}

void menuMode() {
	// CH3: Alternate Inputs
	boolean altInputs = !ch3.getBoolean();  // active low

	// CH1: Menu Navigation X (Left Joy X) | Alt: LB/RB
	int16_t steering = getServoJoy(ch1, Deadzone_Steering, true);

	int16_t menuX   = !altInputs ? steering : 0;
	int16_t bumpers = altInputs ? steering : 0;
	
	XInput.setJoystickX(JOY_LEFT, menuX);
	XInput.setButton(BUTTON_LB, bumpers <= -ButtonThreshold);
	XInput.setButton(BUTTON_RB, bumpers >= ButtonThreshold);

	// CH2: Menu Navigation Y (Left Joy Y) | Alt: Map Zoom (Right Joy Y)
	int16_t throttle = getServoJoy(ch2, Deadzone_Throttle);

	int16_t moveY = !altInputs ? throttle : 0;
	int16_t zoomY =  altInputs ? throttle : 0;

	XInput.setJoystickY(JOY_LEFT, moveY);
	XInput.setJoystickY(JOY_RIGHT, zoomY);

	// CH5: Cancel (B) | Alt: Map (Back)
	boolean topLeft = ch5.getBoolean();

	boolean cancel = topLeft && !altInputs;
	boolean map    = topLeft &&  altInputs;

	XInput.setButton(BUTTON_B, cancel);
	XInput.setButton(BUTTON_BACK, map);

	// CH6: Confirm (A) | Alt: Menu (Start)
	boolean topRight = ch6.getBoolean();

	boolean confirm = topRight && !altInputs;
	boolean start   = topRight &&  altInputs;

	XInput.setButton(BUTTON_A, confirm);
	XInput.setButton(BUTTON_START, start);
}

void extrasMode() {
	// CH3: Alternate Inputs
	boolean altInputs = !ch3.getBoolean();  // active low

	// CH1: DPAD Left/Right | Alt: Horizontal Camera (Right Joy X)
	int16_t steering = getServoJoy(ch1, Deadzone_Steering, true);

	int16_t dpadX   = !altInputs ? steering : 0;
	int16_t cameraX =  altInputs ? steering : 0;

	XInput.setButton(DPAD_LEFT,  dpadX <= -ButtonThreshold);
	XInput.setButton(DPAD_RIGHT, dpadX >= ButtonThreshold);
	XInput.setJoystickX(JOY_RIGHT, cameraX);

	// CH2: DPAD Up/Down | Alt: Veritcal Camera (Right Joy Y)
	int16_t throttle = getServoJoy(ch2, Deadzone_Throttle);

	int16_t dpadY   = !altInputs ? throttle : 0;
	int16_t cameraY =  altInputs ? throttle : 0;

	XInput.setButton(DPAD_DOWN, dpadY <= -ButtonThreshold);
	XInput.setButton(DPAD_UP,   dpadY >= ButtonThreshold);
	XInput.setJoystickY(JOY_RIGHT, cameraY);

	// CH5: Change Camera View (RB)
	boolean camera = ch5.getBoolean();
	XInput.setButton(BUTTON_RB, camera);

	// CH6: Rewind (Y)
	boolean rewind = ch6.getBoolean();
	XInput.setButton(BUTTON_Y, rewind);
}

void printDebug() {
	ServoInputSignal* ptr = ServoInputSignal::getHead();
	uint8_t ch = 1;

	while (ptr != nullptr) {
		char buffer[12] = {};

		sprintf(buffer, "%u: %4u us\t", ch++, (uint16_t) ptr->getPulseRaw());
		Serial.print(buffer);

		ptr = ptr->getNext();
	}
	Serial.println();
}

void bootloaderCheck() {
	/* Since XInput disables the standard upload process, here's an alternate
	 * method without having to open up the case and double-tap the reset pin.
	 * Just hold all three buttons (Ch3, Ch5, and Ch6) for 7 seconds.
	 */

	static const unsigned long HoldTime = 7000;  // ms (7 s)
	static unsigned long lastRelease = 0;

	boolean b1 = !ch3.getBoolean();  // Ch3 (grip) - active low
	boolean b2 = ch5.getBoolean();   // Ch5 (top left)
	boolean b3 = ch6.getBoolean();   // Ch6 (top right)

	if (b1 && b2 && b3) {
		if (millis() - lastRelease >= HoldTime) {
			resetBoard();  // jump to bootloader
		}
	}
	else {
		lastRelease = millis();  // any button released
	}
}

void resetBoard() {
#ifdef __AVR_ATmega32U4__
	// Basic structure borrowed from Teensy 2.0: 
	// https://github.com/PaulStoffregen/cores/blob/fc79132670ac83ce7cae8e2bac64be109fbfe35e/teensy/pins_teensy.c#L1669

	// disable interrupts
	cli();

	// stop watchdog timer, if running
	MCUSR &= ~(1 << WDRF);   // clear "Watchdot Reset Flag" (WDRF) bit (set 0)
	WDTCSR |= (1 << WDCE);   // set "Watchdog Change Enable" (WDCE) bit to 1
	WDTCSR = 0;              // clear "Watchdog Timer Control Register" (WDTCSR)
	_delay_ms(5);            // wait for watchdog change to clear

	// disconnect from USB
	UDCON = 1;               // set "Detach Bit" to disconnect the device
	USBCON = (1 << FRZCLK);  // set the "Freeze USB Clock" bit to disable USB interrupts
	_delay_ms(15);           // wait for USB to disconnect

	// disable peripherals
	EIMSK = 0;   // disable external interrupts (External Interrupt Mask Register)
	PCICR = 0;   // disable pin change interrupts (Pin Change Interrupt Control Register)
	SPCR = 0;    // disable SPI (SPI Control Register)
	ACSR = 0;    // disable analog comparator (Analog Comparator Control and Status Register)
	EECR = 0;    // disable EEPROM writing (EEPROM Control Register)
	ADCSRA = 0;  // disable ADC (ADC Control and Status Register A)
	TIMSK0 = 0;  // disable timer0 interrupts (Timer/Counter Interrupt Mask Register)
	TIMSK1 = 0;  // disable timer1 interrupts (Timer/Counter1 Interrupt Mask Register)
	TIMSK3 = 0;  // disable timer3 interrupts (Timer/Counter3 Interrupt Mask Register)
	TIMSK4 = 0;  // disable timer4 interrupts (Timer/Counter4 Interrupt Mask Register)
	UCSR1B = 0;  // disable USART 1 (USART MSPIM Control and Status Register n B)
	TWCR = 0;    // disable I2C
	DDRB = 0;    // set PORTB pins to "input"
	DDRC = 0;    // set PORTC pins to "input"
	DDRD = 0;    // set PORTD pins to "input"
	DDRE = 0;    // set PORTE pins to "input"
	DDRF = 0;    // set PORTF pins to "input"
	PORTB = 0;   // disable PORTB internal pull-ups
	PORTC = 0;   // disable PORTC internal pull-ups
	PORTD = 0;   // disable PORTD internal pull-ups
	PORTE = 0;   // disable PORTE internal pull-ups
	PORTF = 0;   // disable PORTF internal pull-ups

	// jump to the bootloader address
	// with BOOTSZ fuse = 0x00 (2040 words):
	//     32,768 - 2048 * 2 = 28,672, or 0x7000 in hex
	__asm__ volatile("jmp 0x7000");
	while (1);
#endif
}
