long time1;
float data,Input;

String inputString = "";         // a String to hold incoming data
bool stringComplete = false;  // whether the string is complete



void setup() {
  // put your setup code here, to run once:
Serial.begin(115200);
}

void loop() {
  // put your main code here, to run repeatedly:
time1=millis();
//Serial.print(Input,5);Serial.print(";");
//Serial.print(5);Serial.println(";");
//delay(15);
}

//void serialEvent() {
//  while (Serial.available()>0) {
//    data=Serial.parseFloat();
//    Input=data;
//    Serial.println(Input);
//  }
//}


//void serialEvent() {
//  while (Serial.available()) {
//    // get the new byte:
//    //char inChar = (char)Serial.read();
//    // add it to the inputString:
//    //inputString += inChar;
//    // if the incoming character is a newline, set a flag so the main loop can
//    // do something about it:
//    data=Serial.parseFloat();
//    //if (inChar == '\n') {
//     // stringComplete = true;
//    //}
//  }
//}

void serialEvent(){
  if (Serial.available() > 0) {
    data = Serial.parseFloat();
    Input=data;
    // prints the received float number
//    Serial.print("I received: ");
//    Serial.println(Input);
//    delay(1000);
Serial.print(Input,5);Serial.print(";");
Serial.print(5);Serial.println(";");
  }
}
