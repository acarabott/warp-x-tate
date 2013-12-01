// Arduino Code


 const int sensorNum = 4;
 int sensor[sensorNum] = { 0,0,0,0 };
 
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
 
void loop() {
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
        Serial.println(' ');
    Serial.println('A');   // send a capital A
    
    
    for(int i=0;i<sensorNum;i++) {
      Serial.println(analogRead(i));
    }
    
    Serial.println(' ');
    
    delay(300);
  }
}
