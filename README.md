# Digital Etch A Sketch

## Project Overview

Digital Etch A Sketch is a physical drawing controller built with an ESP32, joystick, push button, potentiometer, and Processing. It recreates the experience of an Etch A Sketch while allowing users to draw digitally with physical controls.

## Design Goals

The goal of this project is to make digital drawing feel more playful and hands-on. Instead of using a mouse, users interact with physical controls to move the drawing cursor, change brush sizes, select colors, and clear the screen. The interface keeps the familiar red frame and simple, nostalgic appearance of the original Etch A Sketch.

## How It Works

- **Joystick:** Moves the drawing cursor around the screen.
- **Joystick click:** Cycles through brush sizes.
- **Push button:** Clears the drawing.
- **Potentiometer:** Changes the drawing color.
- **Processing:** Displays the drawing interface and renders the user's lines.
- **ESP32:** Reads the physical controls and sends their values to Processing over serial communication.

## Hardware

- ESP32 TTGO T-Display
- Joystick module
- Push button
- Potentiometer
- Breadboard and jumper wires
- USB cable
- Mac computer running Arduino IDE and Processing

## Software

- Arduino IDE
- Processing
- Processing Serial library
- ESP32 Arduino board support

## Setup Instructions

1. Connect the joystick, push button, and potentiometer to the ESP32 according to the circuit diagram below.
2. Open the Arduino sketch in Arduino IDE.
3. Select the correct ESP32 board and serial port.
4. Upload the Arduino sketch to the ESP32.
5. Open the Processing sketch.
6. Update the serial port in the Processing code to match the port used by the ESP32.
7. Run the Processing sketch and use the physical controls to draw.

## Circuit Diagram

The Fritzing circuit diagram will be added here.

## Demonstration

![Digital Etch A Sketch Demo](etch-a-sketch-demo.gif)

## Author

Created for a Creative Embedded Systems course project.
