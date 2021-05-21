#include <Arduino.h>
#include <Wire.h>
#include <SoftwareSerial.h>
//SoftwareSerial BT(2,3);
char  Escalon;
int Escalon1;
///FiltroA 
//https://www.megunolink.com/documentation/arduino-libraries/exponential-filter/
#include "MeanFilterLib.h"
MeanFilter<float> meanFilter(20);
#include "MedianFilterLib.h"  //Filtro de Mediana
MedianFilter<float> medianFilter(40);
#include "Filter.h" 
#include "MegunoLink.h"
ExponentialFilter<float> ADCFilter1(35,0);
//FiltroB   
//https://www.youtube.com/watch?v=QGDG5v_UnIk
float Y=0.0;
float alpha1=0.2,alpha2=0.5,alpha3=0.9;
float S21=Y,S22=Y,S23=Y;
int Timeoffset=10000;
//Libreria PWM//
#include <TimerOne.h>
///Sensores
#include "Adafruit_Si7021.h"
#include <Adafruit_Sensor.h>
#include <Adafruit_BME280.h>
#include <Adafruit_ADS1015.h>

//////DHT21//////////////////////////
Adafruit_Si7021 sensor = Adafruit_Si7021();
//////BME280//////////////////////////
Adafruit_BME280 bme; // I2C
////////ADS115////////////////////////
Adafruit_ADS1115 ads;
/////Variables THP ///////////////////
float t=0,t1=0,t2=0;
float h=0,h1=0,h2=0;
float p2=0;
/////Variables Dif - Presion//////////
float presionSF=0,presionSF2=0,presionSF21;
float presionCF1=0,presionCF2=0,presionCF3=0,ADCFilterM=0,ADCFilterM1;
float presionCF21=0,presionCF22=0,presionCF23=0;
float busvoltage=0,adc0=0;
//////Variables velocidad/////////////
float velocidadA=0,velocidadB=0,velocidadA1=0,velocidadB1=0,velocidadC=0,velocidadD=0;
/////////variables-offset/////////////
int contador=0,cancelcontador=0;
float tempref=19.2;
float humref=30.7;
float presionref=102540;
float offsett=0,offsett1=0,offsett2=0;
float offseth=0,offseth1=0,offseth2=0;
float offsetp2=0,offsetdf=0,offsetdf1=2.577;
//////////////////////////////////////
///Constantes Densidad/////
float a0=0.00000158123,a1=-0.000000029331,a2=0.00000000011043;
float b0=0.000005707,b1=-0.00000002051,c0=0.00019898,c1=-0.000002376;
float d=0.0000000000183,e=-0.00000000765,A=0.000012378847,B=-0.019121316;
float C=33.93711047,D=-6343.1645,alfa=1.00062,beta=0.0000000314,gamma=0.00000056;

float P=101220,H=39.8,T=17.7,T1=290.85;
float fpt,psv,xv,Z,den;

boolean paro, BOT=0,BOT2=0,step1=0,step2=0;
float In=0;
long time1, time2,time3;
//////////////////////////
/////Variables Entrada Serial/////
String inputString = "";         // a String to hold incoming data
bool stringComplete = false;  // whether the string is complete
float inputString1=0;
int datos[1];
float data;
////////PID////////
//#include <PID_v2.h>

// Specify the links and initial tuning parameters
double Kp = 0.225, Ki = 0.01, Kd = 0,output=0;//Ki=0.326 Kp=0.225
float VelRef=0;
// variables externas del controlador
double Input, Output, Setpoint;

//PID_v2 myPID(Kp, Ki, Kd,0);
#include <Custom_PID.h>
PID pid(0.225, 0.326, 0);
float Error1=0;


long tiempo=0;
int pw=0,pw1=0;
long Cte=60.17;

void setup() {
  Serial.begin(115200);
  /////SHT21/////////////////
  if (!sensor.begin()) {
    Serial.println("Problema sensor - Si7021");
    while (true);
  }
  /////BME280////////////////////
  if (!bme.begin(0x76)) {
    Serial.println("Problema sensor - BME280");
    while (1);
  }
  /////ADS1115///////////////////////
  ads.setGain(GAIN_ONE);        // 1x gain   +/- 4.096V  1 bit = 2mV      0.125mV
  ads.begin();
  pinMode(7,INPUT_PULLUP);
  ///Inicializo pwm//
  Timer1.initialize(90);

//////////PID//////////////
//
//myPID.Start(velocidadB,  // input
//              0,                      // current output
//              20);                   // setpoint
//myPID.PID::SetOutputLimits(0, 1023);
//myPID.PID::SetSampleTime(50);
////myPID.PID::SetMode(1);
//myPID.PID::SetTunings(Kp,Ki,Kd,P_ON_M);



}

void loop() {
  calculo_offset();
  //escalonserial();
  //escalon2();
  THP(); 
  difPresion();
  vel_tiempo();
  PIDS();
  imprimir_datos();
  //timer_pwm();
  paro = digitalRead(7);
  
  //delay(1000);


//  if (stringComplete) {
//    Serial.println(inputString);
//    // clear the string:
//    inputString = "";
//    stringComplete = false;
//  }
//
//  if (inputString1==65){
//  digitalWrite(13,HIGH);
//  }
//  else{digitalWrite(13,LOW);}



  
}



void serialEvent() {
  while (Serial.available()) {

    // get the new byte:
    //char inChar = (char)Serial.read();
    // add it to the inputString:
    //inputString += inChar;
    //inputString1=Serial.parseInt();
    //char buffer[10];
    //Serial.readBytesUntil('\n', buffer,10);
    //data = atof(buffer);
    data=Serial.parseFloat();
    

    inputString1=data;

  }
}
