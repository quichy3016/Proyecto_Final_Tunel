#include "MedianFilterLib.h"  //Filtro de Mediana
MedianFilter<float> medianFilter(40);
MedianFilter<float> medianFilter1(100);

float ADCFilterM,presionCF21;

#include "Filter.h" 
#include "MegunoLink.h"
ExponentialFilter<float> ADCFilter1(10,0);
ExponentialFilter<float> ADCFilter2(10,0);

float Y=0.0;

float S21=0;

float filtrado, deteccion;

long time1;
float data,Input,Inputant=0;

String inputString = "";         // a String to hold incoming data
bool stringComplete = false;  // whether the string is complete

float miArray[100];

int i=0;

void setup() {
  // put your setup code here, to run once:
Serial.begin(115200);
miArray[0]=1654;
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


ADCFilterM = medianFilter.AddValue(Input);
//S21=(alpha1*Input)+((1-alpha1)*S21); //FiltroB1
ADCFilter1.Filter(Input);
presionCF21 =  ADCFilter1.Current();//FiltroA1
ADCFilter2.Filter(Input);
S21 =  medianFilter1.AddValue(Input);//ADCFilter2.Current();//FiltroA1

//if (ADCFilterM-Inputant>10 | Input-Inputant<10){
//  filtrado=presionCF21;
//  }else{
//    filtrado=ADCFilterM;
//  }

  
Inputant=ADCFilterM;
if (i<100){
miArray[i]=ADCFilterM;
i=i+1;
}else{
  //Serial.println("holasdasd");
  for (int j = 1; j <100; j++){
    miArray[j-1]=miArray[j];
  }
  miArray[99]=ADCFilterM;
}
deteccion=ADCFilterM-miArray[0];
if (deteccion>0.12){
  filtrado=ADCFilterM; 
} else filtrado=S21;

Serial.print(Input,4);Serial.print(";");
Serial.print(ADCFilterM,4);Serial.print(";");
Serial.print(presionCF21,4);Serial.print(";");
Serial.print(deteccion,4);Serial.println(";");
  }
}
