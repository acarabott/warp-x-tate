import oscP5.*;
import netP5.*;

import processing.serial.*;

Serial myPort;                             // The serial port
int sensorNum = 4;
float[] serialInArray = new float[sensorNum];  // Where we'll put what we receive
int serialCount = 0;                       // A count of how many bytes we receive
float[] sensor = new float [sensorNum];                            // Sensor values
boolean firstContact = false;              // Whether we've heard from the microcontroller

float a2, b2, c2, d2;                            // Sensor values
float easing = 0.5;

//String[] sensorKeys = {"303a", "303b", "808a", "808b"};
String[] sensorKeys = {"808b", "fuck1", "fuck2", "fuck3"};
OscP5 oscP5;
NetAddress sclang;


void setup() {
  size(400, 300);
  noFill();
  rectMode(CENTER);
  // Print a list of the serial ports, for debugging purposes:
  println(Serial.list());

  // I know that the last port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[7].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[9];
  myPort = new Serial(this, portName, 19200);
  
  oscP5 = new OscP5(this, 57120);
  sclang = new NetAddress("127.0.0.1", 57120);
}

void sensor(int x, int y, int r, float a, float b, color c) {

  pushMatrix();
  translate(x, y);
  rotate(radians(r));

  // set colour of this plinth
  stroke(c);
  rect(0, 0, 50, 50);
  
  fill(c);

  rotate(radians(90));
  line(0, 0, a, 0);
  rect(a, 0, 5, 5);

  rotate(radians(90));
  line(0, 0, b, 0);
  rect(b, 0, 5, 5);
  
  noFill();
  popMatrix();
  
}

void send() {
   OscMessage message;
   
   for(int i = 0; i < sensorNum; i++) {
     message = new OscMessage("/prox/" + sensorKeys[i]);
     message.add(sensor[i]);
     oscP5.send(message, sclang);
   }
}

void draw() { 
  background(0);
 
  sensor(150, 150, 45, sensor[0],sensor[1], #00C832);
  sensor(250, 150, 225, sensor[2],sensor[3], #00C832);
  
  send();
  
}


void serialEvent(Serial myPort) {
  // read a byte from the serial port:
  int inByte = myPort.read();
  // if this is the first byte received, and it's an A,
  // clear the serial buffer and note that you've
  // had first contact from the microcontroller. 
  // Otherwise, add the incoming byte to the array:
  if (firstContact == false) {
    if (inByte == 'A') { 
      myPort.clear();          // clear the serial port buffer
      firstContact = true;     // you've had first contact from the microcontroller
      myPort.write('A');       // ask for more
    }
  } 
  else {
    // Add the latest byte from the serial port to array:
    serialInArray[serialCount] = inByte;
    serialCount++;

    // If we have 3 bytes:
    if (serialCount > 3 ) {

      for (int i=0;i<sensorNum;i++) {
        float tempX = serialInArray[i] - sensor[i];
        if (abs(tempX) > 1) {
          sensor[i] += tempX * easing;
        }
      }

      // print the values (for debugging purposes only):

//      for (int i=0;i<sensorNum;i++) {
//        print(sensor[i] + "\t");
//      }
      println();

      // Send a capital A to request new sensor readings:
      myPort.write('A');
      // Reset serialCount:
      serialCount = 0;
    }
  }
}

// Arduino Code

/*

 const int sensorNum = 4;
 int sensor[sensorNum] = { 
 0,0,0,0 };
 
 int inByte = 0;         // incoming serial byte
 
 void setup()
 {
 // start serial port at 19200 bps:
 Serial.begin(19200);
 while (!Serial) {
 ; // wait for serial port to connect. Needed for Leonardo only
 }
 
 establishContact();  // send a byte to establish contact until receiver responds 
 }
 
 void loop()
 {
 // if we get a valid byte, read analog ins:
 if (Serial.available() > 0) {
 // get incoming byte:
 inByte = Serial.read();
 
 for(int i=0;i<sensorNum;i++) {
 sensor[i] = analogRead(i);
 // delay 10ms to let the ADC recover:
 delay(10);
 }
 
 for(int i=0;i<sensorNum;i++) {
 Serial.write(sensor[i]);
 delay(10);
 }
 
 }
 }
 
 void establishContact() {
 while (Serial.available() <= 0) {
 Serial.print('A');   // send a capital A
 delay(300);
 }
 }
 
 */
