#include <Arduino.h>
#include <Wire.h>
///FiltroA 
//https://www.megunolink.com/documentation/arduino-libraries/exponential-filter/
#include "MeanFilterLib.h"
MeanFilter<float> meanFilter(20);
#include "MedianFilterLib.h"  //Filtro de Mediana
MedianFilter<float> medianFilter(22);
#include "Filter.h" 
#include "MegunoLink.h"
ExponentialFilter<float> ADCFilter1(30,0);
//FiltroB   
//https://www.youtube.com/watch?v=QGDG5v_UnIk
float Y=0.0;
float alpha1=0.2,alpha2=0.5,alpha3=0.9;
float S21=Y,S22=Y,S23=Y;

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
float presionSF=0,presionSF2=0;
float presionCF1=0,presionCF2=0,presionCF3=0,ADCFilterM=0;
float presionCF21=0,presionCF22=0,presionCF23=0;
float busvoltage=0,adc0=0;
//////Variables velocidad/////////////
float velocidadA=0,velocidadB=0,velocidadA1=0,velocidadB1=0;
/////////variables-offset/////////////
int contador=0,cancelcontador=0;
float tempref=19.2;
float humref=30.7;
float presionref=102540;
float offsett=0,offsett1=0,offsett2=0;
float offseth=0,offseth1=0,offseth2=0;
float offsetp2=0,offsetdf=2.5,offsetdf1=2.5;
//////////////////////////////////////
///Constantes Densidad/////
float a0=0.00000158123,a1=-0.000000029331,a2=0.00000000011043;
float b0=0.000005707,b1=-0.00000002051,c0=0.00019898,c1=-0.000002376;
float d=0.0000000000183,e=-0.00000000765,A=0.000012378847,B=-0.019121316;
float C=33.93711047,D=-6343.1645,alfa=1.00062,beta=0.0000000314,gamma=0.00000056;

float P=101220,H=39.8,T=17.7,T1=290.85;
float fpt,psv,xv,Z,den;
//////////////////////////
long tiempo=0;
int pw=0;
void setup() {
  Serial.begin(250000);
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
  Timer1.initialize(5);

  
}

void loop() {
  calculo_offset();
  escalon();
  THP(); 
  difPresion();
  vel_tiempo();
  imprimir_datos();
  //timer_pwm();
  boolean paro = digitalRead(7);
  Serial.println(paro);
  //delay(1000);
}
