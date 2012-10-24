/*

 Serial RECEIVE and turn ON some Digital pins
 ITP - OCTOBER 2012
 APPLICATION PRESENTATION 
 
 Use with Processing sketch Brightness Detection
 coded and Serial out by Sergio Majluf
 
 Based on Physical Pixel by
 by David A. Mellis & Tom Igoe and Scott Fitzgerald
 
 This example code is in the public domain. 
 http://www.arduino.cc/en/Tutorial/PhysicalPixel
 
 */

const int ledBlockA = 13; // the pin that the LED is attached to
const int ledBlockB = 12;
const int ledBlockC = 11;
const int ledBlockD = 10;
int incomingByte;      // a variable to read incoming serial data into

void setup() {
  // initialize serial communication:
  Serial.begin(9600);
  // initialize the LED pin as an output:
  pinMode(ledBlockA, OUTPUT);
  pinMode(ledBlockB, OUTPUT);
  pinMode(ledBlockC, OUTPUT);
  pinMode(ledBlockD, OUTPUT);
}

void loop() {
  // see if there's incoming serial data:
  if (Serial.available() > 0) {
    // read the oldest byte in the serial buffer:
    incomingByte = Serial.read();
    // if it's a capital H (ASCII 72), turn on the LED:
    if (incomingByte == 'H') {
      digitalWrite(ledBlockA, HIGH);
    } 
    // if it's an L (ASCII 76) turn off the LED:
    if (incomingByte == 'L') {
      digitalWrite(ledBlockA, LOW);
    }
    if (incomingByte == 'U') {
      digitalWrite(ledBlockB, HIGH);
    } 
    // if it's an L (ASCII 76) turn off the LED:
    if (incomingByte == 'D') {
      digitalWrite(ledBlockB, LOW);
    }
    if (incomingByte == 'R') {
      digitalWrite(ledBlockC, HIGH);
    } 
    // if it's an L (ASCII 76) turn off the LED:
    if (incomingByte == 'I') {
      digitalWrite(ledBlockC, LOW);
    }
    if (incomingByte == 'T') {
      digitalWrite(ledBlockD, HIGH);
    } 
    // if it's an L (ASCII 76) turn off the LED:
    if (incomingByte == 'Y') {
      digitalWrite(ledBlockD, LOW);
    }
  }
}


