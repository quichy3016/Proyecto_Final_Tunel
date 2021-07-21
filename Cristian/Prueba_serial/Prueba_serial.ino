#include <Arduino.h>
#include <Wire.h>
#include <SoftwareSerial.h>

bool LUZ=0;
long time1;
float data,Input=5;
void setup() {
  // put your setup code here, to run once:
Serial.begin(115200);
}

void loop() {
  time1=millis();
  // put your main code here, to run repeatedly:
  if (Input==1){
digitalWrite(13,0);
  }
  if (Input==0){
digitalWrite(13,1);
  }
  Serial.print(Input);Serial.print(";");Serial.print(time1);Serial.println(";");
  //delay(1000);
  if(millis()>3000){
    Input=10;
  }
}


//void serialEvent() {
//  while (Serial.available()) {
//    data=Serial.parseFloat();
//    Input=data;
//    //Serial.println(Input);
//  }
//}
