//Librerías
#include <Arduino.h>
#include <Wire.h>
#include <SoftwareSerial.h>
#include "Filter.h"  //Filtro
#include "MegunoLink.h"
#include "MedianFilterLib.h"  //Filtro de Mediana
#include "MeanFilterLib.h"  //Filtro de Media
#include <TimerOne.h> //Libreria PWM
#include "Adafruit_Si7021.h"
#include <Adafruit_Sensor.h>
#include <Adafruit_BME280.h> //sensor THP
#include <Adafruit_ADS1015.h> //Convertidor analógico digital
#include <Custom_PID.h> //Librería modificada
//SoftwareSerial BT(2,3);

//inicialización de variables
//variables utilizadas en PHT
float t1=0,t2=0;
float h1=0,h2=0;
float p2=0;
//////DHT21//////////////////////////
Adafruit_Si7021 sensor = Adafruit_Si7021();
//////BME280//////////////////////////
Adafruit_BME280 bme; // I2C
////////ADS115////////////////////////
Adafruit_ADS1115 ads;


/////Variables Dif - Presion//////////
float presionSF2=0,presionSF21;
float ADCFilterM=0,ADCFilterM1;
float presionCF21=0;
float adc0=0;

//Variables utilizadas en los filtros
MeanFilter<float> meanFilter(20);
MedianFilter<float> medianFilter(40);
ExponentialFilter<float> ADCFilter1(35,0);
float Y=0.0;
float alpha1=0.2;
float S21=Y;


//////Variables velocidad/////////////
float velocidadA=0,velocidadB=0,velocidadC=0,velocidadD=0;
int contador=0;
float offsetp2=0,offsetdf=0,offsetdf1=2.577;
//////////////////////////////////////
///Constantes Densidad/////
float a0=0.00000158123,a1=-0.000000029331,a2=0.00000000011043;
float b0=0.000005707,b1=-0.00000002051,c0=0.00019898,c1=-0.000002376;
float d=0.0000000000183,e=-0.00000000765,A=0.000012378847,B=-0.019121316;
float C=33.93711047,D=-6343.1645,alfa=1.00062,beta=0.0000000314,gamma=0.00000056;

float T1; ////////////////////////////////////////////////////////OJO QUE ESTÁ DEFINIDO EN THP IGUAL
float fpt,psv,xv,Z,den;

boolean paro, BOT=0,BOT2=0,step1=0;
float In=0;
long time1, time2,time3;
//////////////////////////
/////Variables Entrada Serial/////
float inputString1=0; //Almacena datos del Buffer serial
float data; //Guardo los datos del buffer para utilizar en funcion princ.
////////PID////////
double output=0;
float VelRef=0;
// variables externas del controlador


PID pid(0.225, 0.326, 0);
float Error1=0;

long tiempo=0;
int pw=0;
long Cte=56.88;

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
}

void loop() {
  calculo_offset();
  //escalonserial();
  //escalon2();
  THP(); 
  difPresion();
  vel_tiempo();
  PIDS();
  paro = digitalRead(7); 
  imprimir_datos(); 
}



void serialEvent() {
  while (Serial.available()) {
    data=Serial.parseFloat();
    inputString1=data;
  }
}

//Bibliografía
//FiltroA https://www.megunolink.com/documentation/arduino-libraries/exponential-filter/
//FiltroB   https://www.youtube.com/watch?v=QGDG5v_UnIk
//#include <> "" https://es.stackoverflow.com/questions/1959/da-igual-usar-include-iostream-o-include-iostream/1960
